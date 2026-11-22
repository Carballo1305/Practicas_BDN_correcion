#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Genera el diccionario interactivo y el diagrama ER a partir de respaldo2011.sql."""
from __future__ import annotations

import json
import re
from datetime import date
from pathlib import Path

from columns import COLUMN_DESCRIPTIONS
from meta import DOMAINS, TABLE_META, get_relation_description
from parser import load

BASE = Path(__file__).resolve().parent
BACKUPS = BASE.parent
SQL_PATH = BACKUPS / "respaldo2011.sql"
SAMPLES_PATH = BASE / "samples.json"
OUT_MAIN = BACKUPS / "diccionario_datos.html"
OUT_DIAGRAM = BACKUPS / "diagrama_er.html"
OUT_INDEX = BACKUPS / "index_documentacion.html"
TODAY = date.today().isoformat()

MERMAID_LABELS = {
    ("tb_people", "user_ID"): "tiene ficha",
    ("tb_user_addresses", "user_ID"): "registra",
    ("tb_orders", "buyer_ID"): "compra",
    ("tb_orders", "address_ID"): "entrega en",
    ("tb_carts", "user_ID"): "tiene carrito",
    ("tbd_cart_items", "cart_ID"): "contiene",
    ("tbd_cart_items", "provider_ID"): "vendedor",
    ("tbd_cart_items", "product_ID"): "producto",
    ("tbd_order_items", "seller_order_ID"): "pertenece a",
    ("tbd_order_items", "product_ID"): "producto",
    ("tbd_order_items", "provider_ID"): "vendedor",
    ("tb_payments", "order_ID"): "paga",
    ("tb_payments", "payment_method_ID"): "usa",
    ("tb_payment_methods", "payment_method_type_ID"): "es de tipo",
    ("tbd_user_payment_methods", "user_ID"): "guarda",
    ("tbd_user_payment_methods", "payment_method_type_ID"): "es de tipo",
    ("tb_payment_transaction", "payment_ID"): "procesa",
    ("tb_shipments", "order_ID"): "envía",
    ("tb_order_cancellations", "order_ID"): "cancela",
    ("tb_order_cancellations", "user_ID"): "solicita",
    ("tbd_cancellation_items", "cancellation_ID"): "detalla",
    ("tbd_cancellation_items", "order_item_ID"): "cancela",
    ("tb_returns", "order_ID"): "devuelve",
    ("tb_returns", "user_ID"): "solicita",
    ("tbd_return_items", "return_ID"): "detalla",
    ("tbd_return_items", "order_item_ID"): "devuelve",
    ("tb_refunds", "payment_ID"): "reembolsa",
    ("tb_refunds", "return_ID"): "devolución",
    ("tb_refunds", "cancellation_ID"): "cancelación",
    ("tbd_products_categories", "product_ID"): "producto",
    ("tbd_products_categories", "category_ID"): "categoría",
    ("tbd_products_users_providers", "product_ID"): "producto",
    ("tbd_products_users_providers", "user_ID"): "vendedor",
    ("tbd_users_wishlist_products", "user_ID"): "usuario",
    ("tbd_users_wishlist_products", "product_ID"): "producto",
    ("tbd_address_components", "address_ID"): "dirección",
    ("tbd_address_components", "address_ID+address_sup_ID"): "depende de",
    ("tbc_categories", "sup_id_category"): "subcategoría",
}

FALLBACK_COLUMN = "Dato relacionado con el funcionamiento de la tabla."

TABLE_ORDER = [
    "tb_users",
    "tb_people",
    "tb_user_addresses",
    "tbd_address_components",
    "tbc_categories",
    "tb_products",
    "tbd_products_categories",
    "tbd_products_users_providers",
    "tbd_users_wishlist_products",
    "tb_carts",
    "tbd_cart_items",
    "tb_orders",
    "tbd_order_items",
    "tbc_payment_methods_types",
    "tb_payment_methods",
    "tbd_user_payment_methods",
    "tb_payments",
    "tb_payment_transaction",
    "tb_shipments",
    "tb_order_cancellations",
    "tbd_cancellation_items",
    "tb_returns",
    "tbd_return_items",
    "tb_refunds",
    "tb_logs",
]


def mask_name(value: str) -> str:
    value = str(value)
    if "•" in value:
        return value
    return value[:1] + "•" * max(0, len(value) - 1)


def mask_email(value: str) -> str:
    value = str(value)
    if "•" in value:
        return value
    if "@" not in value:
        return mask_name(value)
    local, domain = value.split("@", 1)
    return f"{local[:2]}•••@{domain}"


def sanitize_sample(table: str, sample):
    if not isinstance(sample, dict):
        return sample
    clean = dict(sample)
    if table == "tb_users":
        if clean.get("password") is not None:
            clean["password"] = "••••••••"
        if clean.get("email") is not None:
            clean["email"] = mask_email(clean["email"])
        if clean.get("nick") is not None:
            clean["nick"] = mask_name(clean["nick"])
    if table == "tb_people":
        if clean.get("phone") is not None:
            phone = str(clean["phone"])
            clean["phone"] = phone[:3] + "••••••" + phone[-2:] if len(phone) > 5 else "••••••"
        for key in ("given_names", "family_names"):
            if clean.get(key) is not None:
                clean[key] = mask_name(clean[key])
    if table == "tb_logs":
        if clean.get("description") is not None:
            text = str(clean["description"])
            text = text.replace("\\u0001", " ")
            text = re.sub(r"[^\x20-\x7EáéíóúÁÉÍÓÚñÑüÜ¿¡•…]", " ", text)
            text = re.sub(r"[\w.+-]+@[\w.-]+\.\w+", "•••@•••", text)
            clean["description"] = text[:170] + ("…" if len(text) > 170 else "")
        if clean.get("db_user") is not None:
            clean["db_user"] = mask_email(clean["db_user"])
    if table == "tbd_user_payment_methods":
        for key in ("provider_method_ref", "last_four"):
            if clean.get(key) is not None:
                clean[key] = "••••••••"
    if table == "tb_payment_transaction":
        for key in ("gateway_transaction_id", "gateway_response"):
            if clean.get(key) is not None:
                clean[key] = "••••••••"
    if table == "tb_refunds" and clean.get("refund_reference") is not None:
        clean["refund_reference"] = "••••••••"
    return clean


def column_description(table: str, column: str) -> str:
    return COLUMN_DESCRIPTIONS.get(table, {}).get(column, FALLBACK_COLUMN)


def is_bridge(table: dict) -> bool:
    return len(table["primary_key"]) >= 2 and len(table["foreign_keys"]) >= 2


def fk_cardinality(table: dict, fk: dict) -> str:
    source_cols = set(fk["columns"])
    for unique in table["uniques"]:
        if set(unique["columns"]) == source_cols:
            return "1 : 1"
    if set(table["primary_key"]) == source_cols and len(source_cols) > 1:
        return "N : 1"
    if is_bridge(table):
        return "N : 1"
    return "N : 1"


def mermaid_type(sql_type: str) -> str:
    value = sql_type.lower().strip()
    value = re.sub(r"\(.*?\)", "", value)
    value = value.replace("unsigned", "").replace("zerofill", "").strip()
    if value.startswith("enum"):
        return "enum"
    if value.startswith("bit"):
        return "bit"
    if value.startswith("tinyint"):
        return "tinyint"
    if value.startswith("bigint"):
        return "bigint"
    if value.startswith("smallint"):
        return "smallint"
    if value.startswith("int"):
        return "int"
    if value.startswith("decimal") or value.startswith("numeric"):
        return "decimal"
    if value.startswith("varchar"):
        return "varchar"
    if value.startswith("char"):
        return "char"
    if value.startswith("longtext") or value.startswith("mediumtext") or value.startswith("tinytext"):
        return "text"
    if value.startswith("text"):
        return "text"
    if value.startswith("datetime"):
        return "datetime"
    if value.startswith("timestamp"):
        return "timestamp"
    if value.startswith("date"):
        return "date"
    if value.startswith("json"):
        return "json"
    if value.startswith("binary") or value.startswith("varbinary"):
        return "binary"
    return value or "string"


def mermaid_key(column: dict, fk_columns: set[str]) -> str:
    keys = []
    if column.get("primary_key"):
        keys.append("PK")
    if column["name"] in fk_columns:
        keys.append("FK")
    if column.get("unique"):
        keys.append("UK")
    return ", ".join(keys)


def build_mermaid(tables: list[dict]) -> str:
    lines = ["erDiagram"]
    for table in tables:
        fk_cols = {col for fk in table["foreignKeys"] for col in fk["columns"]}
        selected = []
        seen = set()

        def add(column):
            if column["name"] not in seen:
                selected.append(column)
                seen.add(column["name"])

        for column in table["columns"]:
            if column.get("primary_key") or column["name"] in fk_cols or column.get("unique"):
                add(column)
        preferred = ("name", "description", "status", "amount", "current_price", "email", "given_names", "operation", "table_name", "quantity")
        for key in preferred:
            for column in table["columns"]:
                if column["name"] == key:
                    add(column)
        for column in table["columns"]:
            if len(selected) >= 7:
                break
            add(column)
        selected = selected[:8]

        lines.append(f"  {table['name']} {{")
        for column in selected:
            key = mermaid_key(column, fk_cols)
            suffix = f" {key}" if key else ""
            lines.append(f"    {mermaid_type(column['type'])} {column['name']}{suffix}")
        lines.append("  }")

    lines.append("")
    lines.append("  %% tb_logs registra automáticamente los cambios de las demás tablas.")
    for table in tables:
        for fk in table["foreignKeys"]:
            source = table["name"]
            target = fk["refTable"]
            label = MERMAID_LABELS.get((source, "+".join(fk["columns"])))
            if not label:
                label = MERMAID_LABELS.get((source, fk["columns"][0]), "se relaciona")
            label = label.replace('"', "'")
            if source == target:
                lines.append(f'  {source} ||--o{{ {target} : "{label}"')
            elif fk_cardinality(table, fk) == "1 : 1":
                lines.append(f'  {source} ||--o| {target} : "{label}"')
            else:
                lines.append(f'  {source} }}o--|| {target} : "{label}"')
    return "\n".join(lines)


def build_data() -> dict:
    tables_raw = load(SQL_PATH)
    samples = {}
    if SAMPLES_PATH.exists():
        samples = json.loads(SAMPLES_PATH.read_text(encoding="utf-8"))

    tables = []
    for name, table in tables_raw.items():
        meta = TABLE_META.get(name, {})
        columns = []
        for column in table["columns"]:
            columns.append(
                {
                    "name": column["name"],
                    "type": column["type"],
                    "notNull": column["not_null"],
                    "default": column["default"],
                    "autoIncrement": column["auto_increment"],
                    "primaryKey": column.get("primary_key", False),
                    "primary_key": column.get("primary_key", False),
                    "unique": column.get("unique", False),
                    "uniqueComposite": column.get("unique_composite", False),
                    "description": column_description(name, column["name"]),
                }
            )

        foreign_keys = []
        for fk in table["foreign_keys"]:
            foreign_keys.append(
                {
                    "name": fk["name"],
                    "columns": fk["columns"],
                    "refTable": fk["ref_table"],
                    "refColumns": fk["ref_columns"],
                    "description": get_relation_description(
                        name, fk["columns"][0], fk["ref_table"], fk["ref_columns"][0]
                    ),
                    "cardinality": fk_cardinality(table, fk),
                }
            )

        tables.append(
            {
                "name": name,
                "friendly": meta.get("friendly", name),
                "description": meta.get("description", "Tabla de la base de datos."),
                "domain": meta.get("domain", "auditoria"),
                "icon": meta.get("icon", "🗂️"),
                "rows": table["rows"],
                "columns": columns,
                "foreignKeys": foreign_keys,
                "foreign_keys": table["foreign_keys"],
                "sample": sanitize_sample(name, samples.get(name)),
                "isBridge": is_bridge(table),
                "uniques": table["uniques"],
                "primaryKey": table["primary_key"],
                "primary_key": table["primary_key"],
            }
        )

    order_index = {name: index for index, name in enumerate(TABLE_ORDER)}
    tables.sort(key=lambda item: order_index.get(item["name"], 999))

    total_rows = sum(table["rows"] for table in tables)
    with_data = sum(1 for table in tables if table["rows"] > 0)
    relations = sum(len(table["foreignKeys"]) for table in tables)
    by_name = {table["name"]: table for table in tables}

    return {
        "meta": {
            "database": "db_test",
            "source": "respaldo2011.sql",
            "generated": TODAY,
            "tables": len(tables),
            "totalRows": total_rows,
            "relations": relations,
            "withData": with_data,
            "empty": len(tables) - with_data,
            "users": by_name.get("tb_users", {}).get("rows", 0),
            "products": by_name.get("tb_products", {}).get("rows", 0),
            "logs": by_name.get("tb_logs", {}).get("rows", 0),
            "categories": by_name.get("tbc_categories", {}).get("rows", 0),
        },
        "domains": DOMAINS,
        "tables": tables,
        "mermaid": build_mermaid(tables),
    }


def main() -> None:
    data = build_data()
    data_json = json.dumps(data, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/")
    css = (BASE / "styles.css").read_text(encoding="utf-8")
    app_js = (BASE / "app.js").read_text(encoding="utf-8")
    diagram_js = (BASE / "diagram.js").read_text(encoding="utf-8")
    template = (BASE / "template_main.html").read_text(encoding="utf-8")
    html = (
        template.replace("__CSS__", css)
        .replace("__DATA_JSON__", data_json)
        .replace("__APP_JS__", app_js)
        .replace("__GENERATED__", TODAY)
    )
    OUT_MAIN.write_text(html, encoding="utf-8")

    diagram_template = (BASE / "template_diagram.html").read_text(encoding="utf-8")
    diagram_html = (
        diagram_template.replace("__CSS__", css)
        .replace("__DATA_JSON__", data_json)
        .replace("__DIAGRAM_JS__", diagram_js)
        .replace("__GENERATED__", TODAY)
    )
    OUT_DIAGRAM.write_text(diagram_html, encoding="utf-8")

    index_template = (BASE / "template_index.html").read_text(encoding="utf-8")
    index_html = (
        index_template.replace("__CSS__", css)
        .replace("__GENERATED__", TODAY)
        .replace("__TABLES__", str(data["meta"]["tables"]))
        .replace("__ROWS__", f"{data['meta']['totalRows']:,}")
        .replace("__RELATIONS__", str(data["meta"]["relations"]))
    )
    OUT_INDEX.write_text(index_html, encoding="utf-8")

    print(f"Generado: {OUT_MAIN} ({OUT_MAIN.stat().st_size:,} bytes)")
    print(f"Generado: {OUT_DIAGRAM} ({OUT_DIAGRAM.stat().st_size:,} bytes)")
    print(f"Generado: {OUT_INDEX} ({OUT_INDEX.stat().st_size:,} bytes)")
    print(f"Tablas: {data['meta']['tables']} | Registros: {data['meta']['totalRows']:,} | Relaciones: {data['meta']['relations']}")
    print(f"Mermaid: {len(data['mermaid'].splitlines())} líneas")


if __name__ == "__main__":
    main()
