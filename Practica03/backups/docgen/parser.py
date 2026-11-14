#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Parser del respaldo MySQL: estructura, llaves foráneas y conteo de registros."""
from __future__ import annotations

import re
from pathlib import Path


def read_sql(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def parse_schema(text: str) -> dict:
    create_re = re.compile(r"CREATE TABLE `([^`]+)` \((.*?)\n\) ENGINE=", re.S)
    tables: dict[str, dict] = {}

    for match in create_re.finditer(text):
        name, body = match.group(1), match.group(2)
        columns: list[dict] = []
        primary_key: list[str] = []
        uniques: list[dict] = []
        indexes: list[dict] = []
        foreign_keys: list[dict] = []

        for raw in body.splitlines():
            line = raw.strip()
            if line.startswith("`"):
                col_match = re.match(r"`([^`]+)`\s+(.*)$", line)
                if not col_match:
                    continue
                col_name, rest = col_match.group(1), col_match.group(2)
                attr_re = re.search(
                    r"\s+(NOT NULL|NULL|DEFAULT|AUTO_INCREMENT|COMMENT|ON UPDATE|"
                    r"CHARACTER SET|COLLATE|GENERATED|PRIMARY KEY|UNIQUE)\b",
                    rest,
                    re.I,
                )
                if attr_re:
                    col_type = rest[: attr_re.start()].strip()
                    attrs = rest[attr_re.start() :].strip()
                else:
                    col_type = rest.strip().rstrip(",")
                    attrs = ""

                default = None
                default_match = re.search(
                    r"\bDEFAULT\s+('(?:[^'\\]|\\.)*'|[^\s,]+)", attrs, re.I
                )
                if default_match:
                    default = default_match.group(1)

                comment = None
                comment_match = re.search(
                    r"\bCOMMENT\s+'((?:[^'\\]|\\.)*)'", attrs, re.I
                )
                if comment_match:
                    comment = comment_match.group(1)

                columns.append(
                    {
                        "name": col_name,
                        "type": col_type,
                        "not_null": bool(re.search(r"\bNOT NULL\b", attrs, re.I)),
                        "default": default,
                        "auto_increment": bool(
                            re.search(r"\bAUTO_INCREMENT\b", attrs, re.I)
                        ),
                        "comment": comment,
                    }
                )
            elif line.upper().startswith("PRIMARY KEY"):
                pk_match = re.search(r"PRIMARY KEY\s*\((.*?)\)", line, re.I)
                if pk_match:
                    primary_key = [
                        item.strip().strip("`")
                        for item in pk_match.group(1).split(",")
                    ]
            elif line.upper().startswith("UNIQUE KEY"):
                unique_match = re.search(
                    r"UNIQUE KEY\s+`([^`]+)`\s*\((.*?)\)", line, re.I
                )
                if unique_match:
                    uniques.append(
                        {
                            "name": unique_match.group(1),
                            "columns": [
                                item.strip().strip("`")
                                for item in unique_match.group(2).split(",")
                            ],
                        }
                    )
            elif line.upper().startswith("KEY"):
                index_match = re.search(
                    r"KEY\s+`([^`]+)`\s*\((.*?)\)", line, re.I
                )
                if index_match:
                    indexes.append(
                        {
                            "name": index_match.group(1),
                            "columns": [
                                item.strip().strip("`")
                                for item in index_match.group(2).split(",")
                            ],
                        }
                    )
            elif line.upper().startswith("CONSTRAINT") and "FOREIGN KEY" in line.upper():
                fk_match = re.search(
                    r"CONSTRAINT\s+`([^`]+)`\s+FOREIGN KEY\s*\((.*?)\)\s+"
                    r"REFERENCES\s+`([^`]+)`\s*\((.*?)\)",
                    line,
                    re.I,
                )
                if fk_match:
                    foreign_keys.append(
                        {
                            "name": fk_match.group(1),
                            "columns": [
                                item.strip().strip("`")
                                for item in fk_match.group(2).split(",")
                            ],
                            "ref_table": fk_match.group(3),
                            "ref_columns": [
                                item.strip().strip("`")
                                for item in fk_match.group(4).split(",")
                            ],
                        }
                    )

        single_unique = {
            unique["columns"][0]
            for unique in uniques
            if len(unique["columns"]) == 1
        }
        composite_unique = {
            col
            for unique in uniques
            if len(unique["columns"]) > 1
            for col in unique["columns"]
        }
        for column in columns:
            column["primary_key"] = column["name"] in primary_key
            column["unique"] = column["name"] in single_unique
            column["unique_composite"] = column["name"] in composite_unique

        tables[name] = {
            "name": name,
            "columns": columns,
            "primary_key": primary_key,
            "uniques": uniques,
            "indexes": indexes,
            "foreign_keys": foreign_keys,
            "rows": 0,
        }

    return tables


def _count_tuples(segment: str) -> int:
    count = 0
    depth = 0
    in_quote = False
    quote = ""
    escape = False
    for char in segment:
        if in_quote:
            if escape:
                escape = False
            elif char == "\\":
                escape = True
            elif char == quote:
                in_quote = False
        else:
            if char in ("'", '"'):
                in_quote = True
                quote = char
            elif char == "(":
                depth += 1
                if depth == 1:
                    count += 1
            elif char == ")":
                depth -= 1
    return count


def count_rows(text: str, tables: dict) -> None:
    """Cuenta solo los INSERT de las secciones de datos, no los de triggers."""
    for match in re.finditer(r"-- Dumping data for table `([^`]+)`", text):
        table_name = match.group(1)
        if table_name not in tables:
            continue
        start = match.end()
        end_match = re.search(r"UNLOCK TABLES;", text[start:])
        end = start + end_match.start() if end_match else len(text)
        segment = text[start:end]

        for insert_match in re.finditer(
            r"INSERT INTO `([^`]+)`(?:\s*\([^)]*\))?\s*VALUES", segment, re.I
        ):
            if insert_match.group(1) != table_name:
                continue
            value_start = insert_match.end()
            cursor = value_start
            depth = 0
            in_quote = False
            quote = ""
            escape = False
            while cursor < len(segment):
                char = segment[cursor]
                if in_quote:
                    if escape:
                        escape = False
                    elif char == "\\":
                        escape = True
                    elif char == quote:
                        in_quote = False
                else:
                    if char in ("'", '"'):
                        in_quote = True
                        quote = char
                    elif char == "(":
                        depth += 1
                    elif char == ")":
                        depth -= 1
                    elif char == ";" and depth == 0:
                        break
                cursor += 1
            tables[table_name]["rows"] += _count_tuples(segment[value_start:cursor])


def load(path: Path) -> dict:
    text = read_sql(path)
    tables = parse_schema(text)
    count_rows(text, tables)
    return tables
