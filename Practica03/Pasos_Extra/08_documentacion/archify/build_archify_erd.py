#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Genera el candidato ERD de Archify a partir de respaldo1411.sql.

El ERD conserva todas las columnas físicas, sus tipos SQL, llaves y
referencias. Los valores de los ENUM se documentan en una tarjeta para que
la tabla siga siendo legible sin ocultar el tipo base.
"""
from __future__ import annotations

import json
import math
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
DOCGEN = ROOT / "Practica03" / "backups" / "docgen"
SQL_PATH = ROOT / "Practica03" / "backups" / "respaldo1411.sql"
OUT_DIR = ROOT / "Practica03" / "08_documentacion" / "archify"
OUT_CANDIDATE = OUT_DIR / "candidate.json"
OUTPUT_REL = "Practica03/08_documentacion/archify/erd_practica03.html"

sys.path.insert(0, str(DOCGEN))

from build import MERMAID_LABELS, fk_cardinality  # noqa: E402
from meta import TABLE_META  # noqa: E402
from parser import load  # noqa: E402

DOMAIN_TAGS = {
    "usuarios": "Usuarios",
    "catalogo": "Catálogo",
    "compras": "Compras",
    "pagos": "Pagos",
    "logistica": "Logística",
    "posventa": "Posventa",
    "auditoria": "Auditoría",
}

# Una columna por dominio; logística y auditoría ocupan celdas sueltas para
# mantener el esquema en cinco columnas y evitar una tira horizontal enorme.
PLACEMENT = [
    ("tb_users", "usuarios", 0, 0),
    ("tb_people", "usuarios", 1, 0),
    ("tb_user_addresses", "usuarios", 2, 0),
    ("tbd_address_components", "usuarios", 3, 0),
    ("tb_logs", "auditoria", 4, 0),
    ("tbc_categories", "catalogo", 0, 1),
    ("tb_products", "catalogo", 1, 1),
    ("tbd_products_categories", "catalogo", 2, 1),
    ("tbd_products_users_providers", "catalogo", 3, 1),
    ("tbd_users_wishlist_products", "catalogo", 4, 1),
    ("tb_carts", "compras", 0, 2),
    ("tbd_cart_items", "compras", 1, 2),
    ("tb_orders", "compras", 2, 2),
    ("tbd_order_items", "compras", 3, 2),
    ("tb_shipments", "logistica", 4, 2),
    ("tbc_payment_methods_types", "pagos", 0, 3),
    ("tb_payment_methods", "pagos", 1, 3),
    ("tbd_user_payment_methods", "pagos", 2, 3),
    ("tb_payments", "pagos", 3, 3),
    ("tb_payment_transaction", "pagos", 4, 3),
    ("tb_order_cancellations", "posventa", 0, 4),
    ("tbd_cancellation_items", "posventa", 1, 4),
    ("tb_returns", "posventa", 2, 4),
    ("tbd_return_items", "posventa", 3, 4),
    ("tb_refunds", "posventa", 4, 4),
]

ENUMS = {
    "tb_orders.order_status": "Pending, Processing, Shipped, Delivered, Cancelled",
    "tb_payments.payment_status": "Pending, Completed, Failed, Refunded",
    "tb_order_cancellations.cancellation_status": "Requested, Approved, Rejected",
    "tb_returns.return_status": "Requested, Approved, In Transit, Received, Rejected",
    "tb_shipments.shipment_status": "Preparing, In Transit, Out for Delivery, Delivered, Failed",
    "tb_refunds.refund_status": "Pending, Processed, Failed",
    "tb_people.gender": "Hombre, Mujer, Prefiero no decirlo",
    "tbd_products_users_providers.type_ownership": "Owner, Reseller, Distributor",
}


def key_roles(column: dict, fk_columns: set[str]) -> list[str]:
    roles: list[str] = []
    if column.get("primary_key"):
        roles.append("pk")
    if column["name"] in fk_columns:
        roles.append("fk")
    if column.get("unique") or column.get("unique_composite"):
        roles.append("uk")
    return roles


def key_column_width(role_count: int) -> int:
    if role_count == 0:
        return 30
    return max(30, role_count * 22 + (role_count - 1) * 3 - 2 + 5)


def entity_width(table: dict) -> int:
    fk_columns = {column for fk in table["foreign_keys"] for column in fk["columns"]}
    widest = 240
    for column in table["columns"]:
        sql_type = column["type"]
        # El valor completo del ENUM vive en la tarjeta de restricciones.
        if sql_type.lower().startswith("enum"):
            sql_type = "enum"
        roles = key_roles(column, fk_columns)
        needed = (
            len(column["name"]) * 0.6 * 11
            + (len(sql_type) * 0.6 * 10.5 if sql_type else 0)
            + 8
        )
        width = math.ceil(needed + 24 + key_column_width(len(roles))) + 20
        widest = max(widest, width)
    return widest


def relationship_label(table: str, fk: dict) -> str:
    label = MERMAID_LABELS.get((table, "+".join(fk["columns"])))
    if not label:
        label = MERMAID_LABELS.get((table, fk["columns"][0]))
    return label or "se relaciona"


def build_candidate() -> dict:
    tables = load(SQL_PATH)
    by_name = {name: table for name, table in tables.items()}

    entities = []
    for table_name, domain, row, col in PLACEMENT:
        table = by_name[table_name]
        fk_columns = {column for fk in table["foreign_keys"] for column in fk["columns"]}
        attributes = []
        for column in table["columns"]:
            sql_type = column["type"]
            if sql_type.lower().startswith("enum"):
                sql_type = "enum"
            attribute: dict = {"name": column["name"], "type": sql_type}
            roles = key_roles(column, fk_columns)
            if roles:
                attribute["key"] = roles[0] if len(roles) == 1 else roles
            attributes.append(attribute)

        # Una sola referencia por columna: si participa en varias FK, se
        # conserva la relación no auto-referente y la auto-referencia queda
        # documentada en la tarjeta de auditoría.
        references: dict[str, str] = {}
        for fk in table["foreign_keys"]:
            for source_col, ref_col in zip(fk["columns"], fk["ref_columns"]):
                target = f"{fk['ref_table']}.{ref_col}"
                current = references.get(source_col)
                if current is None or (
                    current.startswith(f"{table_name}.") and fk["ref_table"] != table_name
                ):
                    references[source_col] = target
        for attribute in attributes:
            roles = attribute.get("key", [])
            roles = [roles] if isinstance(roles, str) else roles
            if "fk" in roles:
                attribute["references"] = references[attribute["name"]]

        entities.append(
            {
                "id": table_name,
                "label": table_name,
                "tag": DOMAIN_TAGS[domain],
                "row": row,
                "col": col,
                "width": entity_width(table),
                "attributes": attributes,
            }
        )

    relationships = []
    for table_name, _domain, _row, _col in PLACEMENT:
        table = by_name[table_name]
        for fk in table["foreign_keys"]:
            if fk["ref_table"] == table_name:
                # Una auto-referencia no se dibuja como arista; las columnas
                # siguen declarando su FK en el catálogo.
                continue
            source_cols = set(fk["columns"])
            identifying = source_cols.issubset(set(table["primary_key"]))
            cardinality = fk_cardinality(table, fk)
            from_cardinality = "one" if cardinality == "1 : 1" else "many"
            optional = any(
                not next(c for c in table["columns"] if c["name"] == name)["not_null"]
                for name in fk["columns"]
            )
            rel_id = f"{table_name}__{'+'.join(fk['columns'])}__{fk['ref_table']}"
            rel_id = "".join(ch if ch.isalnum() or ch in "_-" else "_" for ch in rel_id)
            relationship: dict = {
                "id": rel_id,
                "from": table_name,
                "to": fk["ref_table"],
                "label": relationship_label(table_name, fk),
                "fromCardinality": from_cardinality,
                "toCardinality": "one",
                "toOptional": True,
                "identifying": identifying,
            }
            if optional:
                relationship["fromOptional"] = True
            relationships.append(relationship)

    cards = [
        {
            "dot": "cyan",
            "title": "Lectura del esquema",
            "items": [
                "25 tablas y 205 columnas físicas tomadas de respaldo1411.sql.",
                "37 llaves foráneas declaradas: 36 relaciones dibujables y una auto-referencia en tbd_address_components.",
                "Cada tabla conserva todas sus columnas, su tipo SQL y sus roles PK, FK y UK.",
            ],
        },
        {
            "dot": "emerald",
            "title": "Llaves y tablas puente",
            "items": [
                "PK identifica la fila; FK marca la referencia; UK marca una clave única o parte de una clave compuesta.",
                "tbd_products_categories, tbd_products_users_providers, tbd_users_wishlist_products y tbd_cart_items usan PK compuesta.",
                "tbd_order_items, tbd_cancellation_items y tbd_return_items conservan una PK propia y varias FK.",
            ],
        },
        {
            "dot": "violet",
            "title": "Dominios funcionales",
            "items": [
                "Usuarios: tb_users, tb_people, tb_user_addresses, tbd_address_components.",
                "Catálogo: tbc_categories, tb_products, tbd_products_categories, tbd_products_users_providers, tbd_users_wishlist_products.",
                "Compras: tb_carts, tbd_cart_items, tb_orders, tbd_order_items. Logística: tb_shipments.",
                "Pagos: tbc_payment_methods_types, tb_payment_methods, tbd_user_payment_methods, tb_payments, tb_payment_transaction.",
                "Posventa: tb_order_cancellations, tbd_cancellation_items, tb_returns, tbd_return_items, tb_refunds. Auditoría: tb_logs.",
            ],
        },
        {
            "dot": "amber",
            "title": "Valores ENUM",
            "items": [f"{key}: {value}." for key, value in ENUMS.items()],
        },
        {
            "dot": "slate",
            "title": "Auditoría y auto-referencia",
            "items": [
                "tb_logs no declara FK: category_id, product_id y user_id se conservan como columnas, no como aristas.",
                "tbd_address_components.address_sup_ID apunta a otra dirección; la auto-referencia queda como FK de columna.",
                "Los datos de ejemplo y credenciales no forman parte de este ERD.",
            ],
        },
    ]

    return {
        "schema_version": 1,
        "diagram_type": "erd",
        "meta": {
            "title": "Modelo entidad-relación · Práctica 03",
            "locale": "es",
            "output": OUTPUT_REL,
            "quality_profile": "standard",
            "views": [
                {
                    "id": "usuarios",
                    "label": "Usuarios y auditoría",
                    "focus": ["tb_users", "tb_people", "tb_user_addresses", "tbd_address_components", "tb_logs"],
                    "note": "Cuentas, datos personales, direcciones y bitácora.",
                },
                {
                    "id": "catalogo",
                    "label": "Catálogo",
                    "focus": ["tbc_categories", "tb_products", "tbd_products_categories", "tbd_products_users_providers", "tbd_users_wishlist_products"],
                    "note": "Productos, categorías, vendedores y listas de deseos.",
                },
                {
                    "id": "compras",
                    "label": "Compras y envíos",
                    "focus": ["tb_carts", "tbd_cart_items", "tb_orders", "tbd_order_items", "tb_shipments"],
                    "note": "Carrito, pedido, líneas de pedido y envío.",
                },
                {
                    "id": "pagos",
                    "label": "Pagos",
                    "focus": ["tbc_payment_methods_types", "tb_payment_methods", "tbd_user_payment_methods", "tb_payments", "tb_payment_transaction"],
                    "note": "Métodos, pagos y transacciones de pasarela.",
                },
                {
                    "id": "posventa",
                    "label": "Posventa",
                    "focus": ["tb_order_cancellations", "tbd_cancellation_items", "tb_returns", "tbd_return_items", "tb_refunds"],
                    "note": "Cancelaciones, devoluciones y reembolsos.",
                },
            ],
        },
        "layout": {
            "mode": "grid",
            "gapX": 72,
            "gapY": 44,
        },
        "entities": entities,
        "relationships": relationships,
        "cards": cards,
    }


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    candidate = build_candidate()
    OUT_CANDIDATE.write_text(
        json.dumps(candidate, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"Generado: {OUT_CANDIDATE}")
    print(f"Entidades: {len(candidate['entities'])}")
    print(f"Columnas: {sum(len(e['attributes']) for e in candidate['entities'])}")
    print(f"Relaciones: {len(candidate['relationships'])}")


if __name__ == "__main__":
    main()
