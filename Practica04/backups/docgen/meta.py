#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Metadatos de negocio: dominios, nombres amigables y relaciones."""

DOMAINS = [
    {
        "id": "usuarios",
        "name": "Usuarios y personas",
        "icon": "👤",
        "color": "#2563eb",
        "soft": "#e8f0ff",
        "description": "Cuentas, datos personales y direcciones de entrega.",
    },
    {
        "id": "catalogo",
        "name": "Catálogo y vendedores",
        "icon": "🛍️",
        "color": "#0d9488",
        "soft": "#e6fffb",
        "description": "Productos, categorías, vendedores y listas de deseos.",
    },
    {
        "id": "compras",
        "name": "Carrito y pedidos",
        "icon": "🛒",
        "color": "#7c3aed",
        "soft": "#f3e8ff",
        "description": "Lo que el cliente agrega al carrito y los pedidos confirmados.",
    },
    {
        "id": "pagos",
        "name": "Pagos y facturación",
        "icon": "💳",
        "color": "#d97706",
        "soft": "#fff7e6",
        "description": "Métodos de pago, cobros y transacciones.",
    },
    {
        "id": "logistica",
        "name": "Envíos",
        "icon": "🚚",
        "color": "#0284c7",
        "soft": "#e0f2fe",
        "description": "Paquetería, guías y estados de entrega.",
    },
    {
        "id": "posventa",
        "name": "Devoluciones y cancelaciones",
        "icon": "↩️",
        "color": "#dc2626",
        "soft": "#fee2e2",
        "description": "Cancelaciones, devoluciones y reembolsos.",
    },
    {
        "id": "auditoria",
        "name": "Auditoría",
        "icon": "🛡️",
        "color": "#475569",
        "soft": "#f1f5f9",
        "description": "Bitácora automática de cambios en la base de datos.",
    },
]

TABLE_META = {
    "tb_users": {
        "friendly": "Cuentas de usuario",
        "description": "Registro de las personas que pueden iniciar sesión en la tienda, con su correo, alias, rol y estado.",
        "domain": "usuarios",
        "icon": "👤",
    },
    "tb_people": {
        "friendly": "Datos personales",
        "description": "Información personal de cada usuario: nombre, fecha de nacimiento, género, país y teléfono.",
        "domain": "usuarios",
        "icon": "🪪",
    },
    "tb_user_addresses": {
        "friendly": "Direcciones de entrega",
        "description": "Direcciones registradas por los usuarios para recibir sus pedidos.",
        "domain": "usuarios",
        "icon": "📍",
    },
    "tbd_address_components": {
        "friendly": "Componentes de dirección",
        "description": "Partes que forman una dirección: calle, número, colonia, ciudad, estado y código postal.",
        "domain": "usuarios",
        "icon": "🧩",
    },
    "tbc_categories": {
        "friendly": "Categorías",
        "description": "Clasificación de productos en categorías y subcategorías para facilitar su búsqueda.",
        "domain": "catalogo",
        "icon": "🗂️",
    },
    "tb_products": {
        "friendly": "Productos",
        "description": "Catálogo de artículos que se venden en la tienda, con precio, existencias y estado.",
        "domain": "catalogo",
        "icon": "📦",
    },
    "tbd_products_categories": {
        "friendly": "Productos por categoría",
        "description": "Relación que indica a qué categorías pertenece cada producto.",
        "domain": "catalogo",
        "icon": "🔗",
    },
    "tbd_products_users_providers": {
        "friendly": "Productos y vendedores",
        "description": "Relación que indica qué usuario vende o distribuye cada producto.",
        "domain": "catalogo",
        "icon": "🤝",
    },
    "tbd_users_wishlist_products": {
        "friendly": "Lista de deseos",
        "description": "Productos que un usuario guardó como favoritos para comprarlos después.",
        "domain": "catalogo",
        "icon": "💚",
    },
    "tb_carts": {
        "friendly": "Carritos de compra",
        "description": "Guarda temporalmente los productos que un usuario piensa comprar antes de confirmar el pedido.",
        "domain": "compras",
        "icon": "🛒",
    },
    "tbd_cart_items": {
        "friendly": "Productos del carrito",
        "description": "Artículos y cantidades que el usuario agregó a su carrito.",
        "domain": "compras",
        "icon": "🧺",
    },
    "tb_orders": {
        "friendly": "Pedidos",
        "description": "Cada compra confirmada por un cliente, con sus importes y estado de entrega.",
        "domain": "compras",
        "icon": "🧾",
    },
    "tbd_order_items": {
        "friendly": "Productos del pedido",
        "description": "Líneas de producto de cada pedido, con cantidad, precio y vendedor.",
        "domain": "compras",
        "icon": "📋",
    },
    "tbc_payment_methods_types": {
        "friendly": "Tipos de pago",
        "description": "Catálogo de tipos generales de pago: tarjeta, transferencia, efectivo, etc.",
        "domain": "pagos",
        "icon": "🏷️",
    },
    "tb_payment_methods": {
        "friendly": "Métodos de pago",
        "description": "Opciones de pago disponibles en la tienda y el proveedor que las procesa.",
        "domain": "pagos",
        "icon": "💳",
    },
    "tbd_user_payment_methods": {
        "friendly": "Métodos de pago del usuario",
        "description": "Métodos de pago que cada usuario guardó para compras futuras.",
        "domain": "pagos",
        "icon": "🔐",
    },
    "tb_payments": {
        "friendly": "Pagos",
        "description": "Pagos realizados para cubrir un pedido y su estado actual.",
        "domain": "pagos",
        "icon": "💵",
    },
    "tb_payment_transaction": {
        "friendly": "Transacciones de pago",
        "description": "Detalle técnico de cada intento de cobro procesado por la pasarela de pago.",
        "domain": "pagos",
        "icon": "⚙️",
    },
    "tb_shipments": {
        "friendly": "Envíos",
        "description": "Datos de paquetería, número de guía y estado de entrega de cada pedido.",
        "domain": "logistica",
        "icon": "🚚",
    },
    "tb_order_cancellations": {
        "friendly": "Cancelaciones de pedidos",
        "description": "Solicitudes para anular un pedido y su estado de aprobación.",
        "domain": "posventa",
        "icon": "🚫",
    },
    "tbd_cancellation_items": {
        "friendly": "Productos cancelados",
        "description": "Productos específicos que se cancelan dentro de una solicitud de cancelación.",
        "domain": "posventa",
        "icon": "✂️",
    },
    "tb_returns": {
        "friendly": "Devoluciones",
        "description": "Solicitudes de los clientes para regresar un producto de un pedido.",
        "domain": "posventa",
        "icon": "↩️",
    },
    "tbd_return_items": {
        "friendly": "Productos devueltos",
        "description": "Productos específicos incluidos en una devolución.",
        "domain": "posventa",
        "icon": "📦",
    },
    "tb_refunds": {
        "friendly": "Reembolsos",
        "description": "Devoluciones de dinero al cliente por una devolución o cancelación.",
        "domain": "posventa",
        "icon": "💰",
    },
    "tb_logs": {
        "friendly": "Bitácora de auditoría",
        "description": "Registra automáticamente cada cambio realizado en la base de datos: quién lo hizo, cuándo y sobre qué tabla.",
        "domain": "auditoria",
        "icon": "🛡️",
    },
}

# Descripciones amigables de cada relación (llave foránea).
RELATION_DESCRIPTIONS = {
    "tb_users": {
        "tb_people.user_ID": "Cada ficha personal corresponde a una cuenta de usuario.",
        "tb_user_addresses.user_ID": "Cada dirección pertenece a un usuario.",
        "tb_orders.buyer_ID": "Cada pedido es realizado por un comprador.",
        "tb_carts.user_ID": "Cada carrito pertenece a una cuenta de usuario.",
        "tb_order_cancellations.user_ID": "La cancelación la solicita un usuario.",
        "tb_returns.user_ID": "La devolución la solicita un usuario.",
        "tbd_user_payment_methods.user_ID": "El método de pago guardado pertenece a un usuario.",
        "tbd_products_users_providers.user_ID": "El vendedor o proveedor es una cuenta de usuario.",
        "tbd_users_wishlist_products.user_ID": "La lista de deseos pertenece a un usuario.",
    },
    "tb_people": {
        "tb_users.ID": "Cada ficha personal se conecta con su cuenta de usuario.",
    },
    "tb_user_addresses": {
        "tb_orders.address_ID": "Cada pedido se entrega en una dirección registrada.",
        "tbd_address_components.address_ID": "Cada componente forma parte de una dirección.",
    },
    "tbc_categories": {
        "tbd_products_categories.category_ID": "Cada relación asigna una categoría al producto.",
        "tbc_categories.sup_id_category": "Una categoría puede depender de otra categoría superior.",
    },
    "tb_products": {
        "tbd_products_categories.product_ID": "Cada relación asigna un producto del catálogo.",
        "tbd_products_users_providers.product_ID": "Cada producto es ofrecido por un vendedor.",
        "tbd_users_wishlist_products.product_ID": "La lista de deseos contiene productos del catálogo.",
    },
    "tb_carts": {
        "tbd_cart_items.cart_ID": "Cada artículo está dentro de un carrito.",
    },
    "tb_orders": {
        "tbd_order_items.seller_order_ID": "Cada línea de pedido pertenece a un pedido.",
        "tb_payments.order_ID": "Cada pago corresponde a un pedido.",
        "tb_shipments.order_ID": "Cada envío corresponde a un pedido.",
        "tb_order_cancellations.order_ID": "Cada cancelación corresponde a un pedido.",
        "tb_returns.order_ID": "Cada devolución corresponde a un pedido.",
    },
    "tbd_order_items": {
        "tbd_cancellation_items.order_item_ID": "Se cancela un producto específico del pedido.",
        "tbd_return_items.order_item_ID": "Se devuelve un producto específico del pedido.",
    },
    "tbc_payment_methods_types": {
        "tb_payment_methods.payment_method_type_ID": "Cada método de pago pertenece a un tipo general.",
        "tbd_user_payment_methods.payment_method_type_ID": "El método guardado es de un tipo general.",
    },
    "tb_payment_methods": {
        "tb_payments.payment_method_ID": "El pago utiliza un método registrado.",
    },
    "tb_payments": {
        "tb_payment_transaction.payment_ID": "Cada transacción procesa un pago.",
        "tb_refunds.payment_ID": "El reembolso se aplica sobre un pago.",
    },
    "tb_order_cancellations": {
        "tbd_cancellation_items.cancellation_ID": "Cada detalle pertenece a una solicitud de cancelación.",
        "tb_refunds.cancellation_ID": "El reembolso puede originarse por una cancelación.",
    },
    "tb_returns": {
        "tbd_return_items.return_ID": "Cada producto devuelto pertenece a una devolución.",
        "tb_refunds.return_ID": "El reembolso puede originarse por una devolución.",
    },
    "tbd_products_users_providers": {
        "tbd_cart_items.provider_ID": "El artículo del carrito identifica al vendedor.",
        "tbd_cart_items.product_ID": "El artículo del carrito identifica el producto ofrecido.",
        "tbd_order_items.product_ID": "La línea del pedido identifica el producto vendido.",
        "tbd_order_items.provider_ID": "La línea del pedido identifica al vendedor que surte.",
    },
    "tbd_address_components": {
        "tbd_address_components.address_ID": "Un componente puede depender de otro componente superior (jerarquía de la dirección).",
    },
}


def get_relation_description(source: str, column: str, ref_table: str, ref_column: str) -> str:
    direct = RELATION_DESCRIPTIONS.get(source, {}).get(f"{source}.{column}")
    if direct:
        return direct
    reverse = RELATION_DESCRIPTIONS.get(ref_table, {}).get(f"{source}.{column}")
    if reverse:
        return reverse
    return (
        f"Los registros de {source} se conectan con {ref_table} "
        f"a través del campo {column}."
    )
