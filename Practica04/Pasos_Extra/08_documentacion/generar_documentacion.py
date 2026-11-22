# -*- coding: utf-8 -*-
"""
Genera el diccionario de datos y el MERE de la Practica 03
a partir de information_schema de la base db_test.
"""
import csv
import subprocess
from collections import OrderedDict
from pathlib import Path

MYSQL = r"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
CNF = r"C:\Users\Public\my_practica.cnf"
OUT = Path(r"C:\Users\Aaron Carballo\Documents\Proyecto predeterminado\Practica03\08_documentacion")

DESCRIPCIONES = {
    "tb_users": "Usuarios de la plataforma (compradores, vendedores y personal).",
    "tb_people": "Datos personales y demograficos asociados a un usuario.",
    "tb_user_addresses": "Direcciones registradas por cada usuario.",
    "tbd_address_components": "Componentes jerarquicos de una direccion (pais, estado, ciudad, colonia, calle).",
    "tb_products": "Catalogo de productos publicados.",
    "tbc_categories": "Catalogo jerarquico de categorias y subcategorias.",
    "tbd_products_categories": "Relacion muchos-a-muchos entre productos y categorias.",
    "tbd_products_users_providers": "Relacion producto-proveedor; identifica al vendedor de cada producto.",
    "tb_carts": "Carritos de compra de los usuarios.",
    "tbd_cart_items": "Productos agregados a un carrito.",
    "tb_orders": "Pedidos generados a partir de un carrito.",
    "tbd_order_items": "Detalle de productos y cantidades de un pedido.",
    "tb_order_cancellations": "Solicitudes de cancelacion de pedidos.",
    "tbd_cancellation_items": "Detalle de los items cancelados.",
    "tb_payments": "Pagos asociados a un pedido.",
    "tb_payment_methods": "Metodos de pago disponibles por tipo.",
    "tbc_payment_methods_types": "Tipos de metodo de pago (tarjeta, transferencia, etc.).",
    "tbd_user_payment_methods": "Metodos de pago registrados por cada usuario.",
    "tb_payment_transaction": "Transacciones y respuestas de la pasarela de pago.",
    "tb_shipments": "Envios y seguimiento de pedidos.",
    "tb_returns": "Devoluciones solicitadas por los usuarios.",
    "tbd_return_items": "Detalle de productos devueltos.",
    "tb_refunds": "Reembolsos originados por devoluciones o cancelaciones.",
    "tbd_users_wishlist_products": "Lista de deseos de los usuarios.",
    "tb_logs": "Bitacora de auditoria generada por los 72 triggers.",
}

NOMBRES = {
    "tb_users": "Usuario",
    "tb_people": "Persona",
    "tb_user_addresses": "Direccion de usuario",
    "tbd_address_components": "Componente de direccion",
    "tb_products": "Producto",
    "tbc_categories": "Categoria",
    "tbd_products_categories": "Producto-Categoria",
    "tbd_products_users_providers": "Producto-Proveedor",
    "tb_carts": "Carrito",
    "tbd_cart_items": "Item de carrito",
    "tb_orders": "Pedido",
    "tbd_order_items": "Item de pedido",
    "tb_order_cancellations": "Cancelacion",
    "tbd_cancellation_items": "Item de cancelacion",
    "tb_payments": "Pago",
    "tb_payment_methods": "Metodo de pago",
    "tbc_payment_methods_types": "Tipo de metodo de pago",
    "tbd_user_payment_methods": "Metodo de pago del usuario",
    "tb_payment_transaction": "Transaccion de pago",
    "tb_shipments": "Envio",
    "tb_returns": "Devolucion",
    "tbd_return_items": "Item de devolucion",
    "tb_refunds": "Reembolso",
    "tbd_users_wishlist_products": "Lista de deseos",
    "tb_logs": "Bitacora",
}

# Etiquetas legibles para las relaciones del diagrama MERE.
RELACIONES = {
    ("tb_users", "tb_people"): "tiene",
    ("tb_users", "tb_user_addresses"): "registra",
    ("tb_users", "tb_carts"): "posee",
    ("tb_users", "tb_orders"): "compra",
    ("tb_users", "tb_returns"): "solicita",
    ("tb_users", "tb_order_cancellations"): "solicita",
    ("tb_users", "tbd_products_users_providers"): "vende",
    ("tb_users", "tbd_user_payment_methods"): "registra",
    ("tb_users", "tbd_users_wishlist_products"): "desea",
    ("tb_user_addresses", "tbd_address_components"): "compone",
    ("tb_user_addresses", "tb_orders"): "entrega_en",
    ("tb_carts", "tbd_cart_items"): "contiene",
    ("tb_products", "tbd_cart_items"): "se_agrega",
    ("tbd_products_users_providers", "tbd_cart_items"): "se_agrega",
    ("tbd_products_users_providers", "tbd_order_items"): "incluye",
    ("tbd_address_components", "tbd_address_components"): "padre_hijo",
    ("tb_products", "tbd_products_categories"): "clasifica",
    ("tbc_categories", "tbd_products_categories"): "agrupa",
    ("tb_products", "tbd_products_users_providers"): "oferta",
    ("tb_orders", "tbd_order_items"): "contiene",
    ("tb_products", "tbd_order_items"): "incluye",
    ("tb_orders", "tb_payments"): "genera",
    ("tb_payment_methods", "tb_payments"): "usa",
    ("tbc_payment_methods_types", "tb_payment_methods"): "clasifica",
    ("tbc_payment_methods_types", "tbd_user_payment_methods"): "clasifica",
    ("tb_payments", "tb_payment_transaction"): "procesa",
    ("tb_orders", "tb_shipments"): "envia",
    ("tb_orders", "tb_returns"): "devuelve",
    ("tb_returns", "tbd_return_items"): "detalla",
    ("tbd_order_items", "tbd_return_items"): "referencia",
    ("tb_orders", "tb_order_cancellations"): "cancela",
    ("tb_order_cancellations", "tbd_cancellation_items"): "detalla",
    ("tbd_order_items", "tbd_cancellation_items"): "referencia",
    ("tb_payments", "tb_refunds"): "reembolsa",
    ("tb_returns", "tb_refunds"): "origina",
    ("tb_order_cancellations", "tb_refunds"): "origina",
    ("tb_products", "tbd_users_wishlist_products"): "lista",
}


def query(sql: str):
    result = subprocess.run(
        [MYSQL, f"--defaults-file={CNF}", "--batch", "--raw", "--skip-column-names", "-e", sql],
        capture_output=True, text=True, encoding="utf-8",
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr)
    rows = []
    for line in result.stdout.splitlines():
        rows.append(line.split("\t"))
    return rows


def main():
    OUT.mkdir(parents=True, exist_ok=True)

    tables = query(
        "SELECT TABLE_NAME, TABLE_TYPE FROM information_schema.TABLES "
        "WHERE TABLE_SCHEMA='db_test' ORDER BY TABLE_TYPE, TABLE_NAME"
    )
    base_tables = [r[0] for r in tables if r[1] == "BASE TABLE"]
    views = [r[0] for r in tables if r[1] == "VIEW"]

    columns = query(
        "SELECT c.TABLE_NAME, c.ORDINAL_POSITION, c.COLUMN_NAME, c.COLUMN_TYPE, "
        "c.IS_NULLABLE, c.COLUMN_KEY, IFNULL(c.COLUMN_DEFAULT,'NULL'), c.EXTRA, "
        "REPLACE(REPLACE(IFNULL(c.COLUMN_COMMENT,''),'\\t',' '),'\\n',' ') "
        "FROM information_schema.COLUMNS c "
        "JOIN information_schema.TABLES t ON t.TABLE_SCHEMA=c.TABLE_SCHEMA "
        " AND t.TABLE_NAME=c.TABLE_NAME AND t.TABLE_TYPE='BASE TABLE' "
        "WHERE c.TABLE_SCHEMA='db_test' "
        "ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION"
    )

    fks = query(
        "SELECT kcu.TABLE_NAME, kcu.COLUMN_NAME, kcu.REFERENCED_TABLE_NAME, "
        "kcu.REFERENCED_COLUMN_NAME, rc.DELETE_RULE, rc.UPDATE_RULE "
        "FROM information_schema.KEY_COLUMN_USAGE kcu "
        "JOIN information_schema.REFERENTIAL_CONSTRAINTS rc "
        " ON rc.CONSTRAINT_SCHEMA=kcu.CONSTRAINT_SCHEMA "
        " AND rc.CONSTRAINT_NAME=kcu.CONSTRAINT_NAME "
        "WHERE kcu.TABLE_SCHEMA='db_test' AND kcu.REFERENCED_TABLE_NAME IS NOT NULL "
        "ORDER BY kcu.TABLE_NAME, kcu.COLUMN_NAME"
    )
    fk_map = {}
    for t, col, rt, rcol, dr, ur in fks:
        fk_map.setdefault(t, []).append((col, rt, rcol, dr, ur))

    counts = OrderedDict()
    for t in base_tables:
        counts[t] = int(query(f"SELECT COUNT(*) FROM db_test.`{t}`")[0][0])

    # ---------------- CSV ----------------
    csv_path = OUT / "diccionario_datos.csv"
    with csv_path.open("w", newline="", encoding="utf-8-sig") as f:
        w = csv.writer(f)
        w.writerow(["Tabla", "No.", "Columna", "Tipo de dato", "Nulo", "Llave",
                    "Valor por defecto", "Extra", "Referencia FK", "Regla borrado",
                    "Regla actualizacion", "Comentario"])
        for t in base_tables:
            rel = {c[0]: c for c in fk_map.get(t, [])}
            for row in [r for r in columns if r[0] == t]:
                _, pos, col, ctype, nullable, key, default, extra, comment = row
                ref = rel.get(col)
                w.writerow([
                    t, pos, col, ctype, "Si" if nullable == "YES" else "No",
                    key, default, extra,
                    f"{ref[1]}.{ref[2]}" if ref else "",
                    ref[3] if ref else "", ref[4] if ref else "", comment,
                ])

    # ---------------- Markdown diccionario ----------------
    md = []
    md.append("# Diccionario de datos - `db_test`")
    md.append("")
    md.append("**Proyecto:** Practica 03 - Bases de datos en la nube  ")
    md.append("**Motor:** MySQL 8.0.46  ")
    md.append("**Base de datos:** `db_test`  ")
    md.append("**Generado:** 12/11/2026 a partir de `information_schema`")
    md.append("")
    md.append(f"La base contiene **{len(base_tables)} tablas** y **{len(views)} vistas**. "
              f"El detalle completo por columna tambien esta disponible en "
              f"[`diccionario_datos.csv`](diccionario_datos.csv).")
    md.append("")
    md.append("## Resumen de tablas")
    md.append("")
    md.append("| # | Tabla | Descripcion | Columnas | Registros |")
    md.append("|---|-------|-------------|----------|-----------|")
    for i, t in enumerate(base_tables, 1):
        ncols = len([r for r in columns if r[0] == t])
        md.append(f"| {i} | `{t}` | {DESCRIPCIONES.get(t, '')} | {ncols} | {counts[t]:,} |")
    md.append("")
    md.append("## Detalle de tablas")
    md.append("")
    for t in base_tables:
        md.append(f"### `{t}`")
        md.append("")
        md.append(f"{DESCRIPCIONES.get(t, '')}  ")
        md.append(f"**Registros:** {counts[t]:,}")
        md.append("")
        md.append("| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |")
        md.append("|-----|---------|------|------|-------|---------|-------|----|")
        rel = {c[0]: c for c in fk_map.get(t, [])}
        for row in [r for r in columns if r[0] == t]:
            _, pos, col, ctype, nullable, key, default, extra, comment = row
            ref = rel.get(col)
            fk = f"`{ref[1]}.{ref[2]}`" if ref else ""
            md.append(f"| {pos} | `{col}` | `{ctype}` | {'Si' if nullable == 'YES' else 'No'} | "
                      f"{key} | {default} | {extra} | {fk} |")
        md.append("")
        if rel:
            md.append("**Llaves foraneas:**")
            md.append("")
            for col, rt, rcol, dr, ur in rel.values():
                md.append(f"- `{col}` -> `{rt}.{rcol}` (DELETE {dr}, UPDATE {ur})")
            md.append("")

    md.append("## Vistas")
    md.append("")
    md.append("| # | Vista | Proposito |")
    md.append("|---|-------|-----------|")
    view_desc = {
        "vw_productos_por_categoria": "Catalogo agregado de productos por categoria.",
        "vw_trazabilidad_usuarios": "Trazabilidad de usuarios (sin password).",
    }
    for i, v in enumerate(views, 1):
        desc = view_desc.get(v, "Vista de trazabilidad de la tabla " + v.replace("vw_trazabilidad_", "tb_").replace("vw_productos_por_categoria", ""))
        md.append(f"| {i} | `{v}` | {desc} |")
    md.append("")

    (OUT / "diccionario_datos.md").write_text("\n".join(md), encoding="utf-8")

    # ---------------- MERE ----------------
    # Cardinalidad: 1:1 si la columna FK es unica; 1:N en caso contrario.
    unique_cols = set()
    idx_cols = {}
    for r in query(
        "SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME FROM information_schema.STATISTICS "
        "WHERE TABLE_SCHEMA='db_test' AND NON_UNIQUE=0 "
        "ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX"
    ):
        idx_cols.setdefault((r[0], r[1]), []).append(r[2])
    for (tbl, _idx), cols in idx_cols.items():
        if len(cols) == 1:
            unique_cols.add((tbl, cols[0]))

    mere = []
    mere.append("# MERE - Modelo Entidad-Relacion Extendido")
    mere.append("")
    mere.append("**Proyecto:** Practica 03 - Bases de datos en la nube  ")
    mere.append("**Base de datos:** `db_test`  ")
    mere.append("**Modelo:** relacional, 24 tablas operativas + 1 tabla de auditoria")
    mere.append("")
    mere.append("## 1. Objetivo")
    mere.append("")
    mere.append("Describir las entidades, atributos y relaciones del sistema de comercio "
                "electronico implementado en `db_test`, incluyendo la trazabilidad de "
                "operaciones mediante la tabla `tb_logs`.")
    mere.append("")
    mere.append("## 2. Entidades principales")
    mere.append("")
    mere.append("| Entidad | Tabla | Descripcion |")
    mere.append("|---------|-------|-------------|")
    for t in ["tb_users", "tb_people", "tb_user_addresses", "tb_products", "tbc_categories",
              "tb_carts", "tb_orders", "tb_payments", "tb_shipments", "tb_returns",
              "tb_order_cancellations", "tb_refunds"]:
        mere.append(f"| {NOMBRES[t]} | `{t}` | {DESCRIPCIONES[t]} |")
    mere.append("")
    mere.append("## 3. Entidades de relacion")
    mere.append("")
    mere.append("| Entidad | Tabla | Descripcion |")
    mere.append("|---------|-------|-------------|")
    for t in ["tbd_address_components", "tbd_products_categories", "tbd_products_users_providers",
              "tbd_cart_items", "tbd_order_items", "tbd_cancellation_items", "tbd_return_items",
              "tbd_user_payment_methods", "tbd_users_wishlist_products", "tb_payment_methods",
              "tbc_payment_methods_types", "tb_payment_transaction", "tb_logs"]:
        mere.append(f"| {NOMBRES[t]} | `{t}` | {DESCRIPCIONES[t]} |")
    mere.append("")
    mere.append("## 4. Diagrama MERE")
    mere.append("")
    mere.append("```mermaid")
    mere.append("erDiagram")
    # Entidades con atributos clave
    key_attrs = {
        "tb_users": ["int ID PK", "varchar email", "varchar nick", "varchar roles", "bit status"],
        "tb_people": ["int ID PK", "int user_ID FK", "varchar given_names", "date birth_date"],
        "tb_user_addresses": ["int ID PK", "int user_ID FK", "varchar address"],
        "tbd_address_components": ["int ID PK", "int address_ID FK", "int address_sup_ID FK"],
        "tb_products": ["int ID PK", "varchar SKU", "varchar name", "decimal current_price", "bit status"],
        "tbc_categories": ["int id PK", "varchar category_name", "int category_level"],
        "tbd_products_categories": ["int product_ID PK,FK", "int category_ID PK,FK"],
        "tbd_products_users_providers": ["int product_ID PK,FK", "int user_ID PK,FK"],
        "tb_carts": ["int ID PK", "int user_ID FK", "bit status"],
        "tbd_cart_items": ["int ID PK", "int cart_ID FK", "int product_ID FK"],
        "tb_orders": ["int ID PK", "int buyer_ID FK", "int address_ID FK", "decimal total"],
        "tbd_order_items": ["int ID PK", "int seller_order_ID FK", "int product_ID FK"],
        "tb_order_cancellations": ["int ID PK", "int order_ID FK", "int user_ID FK"],
        "tbd_cancellation_items": ["int ID PK", "int cancellation_ID FK", "int order_item_ID FK"],
        "tb_payments": ["int ID PK", "int order_ID FK", "decimal amount"],
        "tb_payment_methods": ["int ID PK", "int payment_method_type_ID FK"],
        "tbc_payment_methods_types": ["int ID PK", "varchar name"],
        "tbd_user_payment_methods": ["int ID PK", "int user_ID FK", "int payment_method_type_ID FK"],
        "tb_payment_transaction": ["int ID PK", "int payment_ID FK", "varchar gateway_response"],
        "tb_shipments": ["int ID PK", "int order_ID FK", "varchar tracking_number"],
        "tb_returns": ["int ID PK", "int order_ID FK", "int user_ID FK"],
        "tbd_return_items": ["int ID PK", "int return_ID FK", "int order_item_ID FK"],
        "tb_refunds": ["int ID PK", "int payment_ID FK", "int return_ID FK", "int cancellation_ID FK"],
        "tbd_users_wishlist_products": ["int ID PK", "int user_ID FK", "int product_ID FK"],
        "tb_logs": ["int ID PK", "varchar table_name", "varchar operation", "varchar db_user", "datetime date"],
    }
    for ent, attrs in key_attrs.items():
        mere.append(f"    {ent} {{")
        for a in attrs:
            mere.append(f"        {a}")
        mere.append("    }")
    mere.append("")
    # Relaciones (una por par origen-destino)
    seen = set()
    for t, lst in fk_map.items():
        for col, rt, rcol, dr, ur in lst:
            pair = (t, rt)
            if pair in seen:
                continue
            seen.add(pair)
            label = RELACIONES.get((rt, t), "relaciona")
            # 1:1 si la FK es unica; en otro caso 1:N
            card = "||--o|" if (t, col) in unique_cols else "||--o{"
            mere.append(f'    {rt} {card} {t} : "{label}"')
    # Relacion de auditoria (sin FK fisica)
    mere.append('    tb_logs }o--o{ tb_users : "audita"')
    mere.append("```")
    mere.append("")
    mere.append("> Nota: `tb_logs` no tiene llave foranea fisica; se relaciona logicamente "
                "con todas las tablas mediante `table_name` + `record_id`.")
    mere.append("")
    mere.append("## 5. Cardinalidades")
    mere.append("")
    mere.append("| Entidad padre | Entidad hija | Cardinalidad | Regla de negocio |")
    mere.append("|---------------|--------------|--------------|------------------|")
    seen2 = set()
    for t, lst in fk_map.items():
        for col, rt, rcol, dr, ur in lst:
            pair = (t, rt)
            if pair in seen2:
                continue
            seen2.add(pair)
            if pair == ("tbd_address_components", "tbd_address_components"):
                card = "1:N (jerarquia)"
            elif (t, col) in unique_cols:
                card = "1:1"
            else:
                card = "1:N"
            label = RELACIONES.get((rt, t), "relaciona").replace("_", " ")
            mere.append(f"| `{rt}` | `{t}` | {card} | Un registro de `{rt}` {label} muchos de `{t}`. |")
    mere.append("")
    mere.append("## 6. Reglas de negocio")
    mere.append("")
    mere.append("1. Un usuario puede tener cero o un registro en `tb_people` (1:1).")
    mere.append("2. Un usuario puede registrar varias direcciones, carritos, pedidos y metodos de pago.")
    mere.append("3. Un producto pertenece al menos a una categoria mediante `tbd_products_categories`.")
    mere.append("4. Un producto es ofertado por un vendedor en `tbd_products_users_providers`.")
    mere.append("5. Un pedido se compone de uno o varios `tbd_order_items` y puede generar uno o varios pagos.")
    mere.append("6. Un pago puede tener varias transacciones; al eliminar el pago se eliminan sus transacciones (CASCADE).")
    mere.append("7. Una devolucion o cancelacion puede originar un reembolso.")
    mere.append("8. Las categorias y direcciones son jerarquicas (auto-referencia).")
    mere.append("9. La baja de productos es logica (`status = 0`), no fisica.")
    mere.append("10. Toda operacion INSERT/UPDATE/DELETE sobre las 24 tablas operativas se registra en `tb_logs` mediante 72 triggers.")
    mere.append("")

    (OUT / "mere.md").write_text("\n".join(mere), encoding="utf-8")

    print(f"Tablas: {len(base_tables)} | Vistas: {len(views)} | FKs: {len(fks)}")
    print(f"Generado: {csv_path.name}, diccionario_datos.md, mere.md")


if __name__ == "__main__":
    main()
