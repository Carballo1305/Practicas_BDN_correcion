# Diccionario de datos - `db_test`

**Proyecto:** Practica 03 - Bases de datos en la nube  
**Motor:** MySQL 8.0.46  
**Base de datos:** `db_test`  
**Generado:** 12/11/2026 a partir de `information_schema`

La base contiene **25 tablas** y **25 vistas**. El detalle completo por columna tambien esta disponible en [`diccionario_datos.csv`](diccionario_datos.csv).

## Resumen de tablas

| # | Tabla | Descripcion | Columnas | Registros |
|---|-------|-------------|----------|-----------|
| 1 | `tb_carts` | Carritos de compra de los usuarios. | 5 | 0 |
| 2 | `tb_logs` | Bitacora de auditoria generada por los 72 triggers. | 11 | 68,888 |
| 3 | `tb_order_cancellations` | Solicitudes de cancelacion de pedidos. | 8 | 0 |
| 4 | `tb_orders` | Pedidos generados a partir de un carrito. | 11 | 0 |
| 5 | `tb_payment_methods` | Metodos de pago disponibles por tipo. | 7 | 0 |
| 6 | `tb_payment_transaction` | Transacciones y respuestas de la pasarela de pago. | 7 | 0 |
| 7 | `tb_payments` | Pagos asociados a un pedido. | 10 | 0 |
| 8 | `tb_people` | Datos personales y demograficos asociados a un usuario. | 12 | 7,502 |
| 9 | `tb_products` | Catalogo de productos publicados. | 9 | 12,000 |
| 10 | `tb_refunds` | Reembolsos originados por devoluciones o cancelaciones. | 11 | 0 |
| 11 | `tb_returns` | Devoluciones solicitadas por los usuarios. | 8 | 0 |
| 12 | `tb_shipments` | Envios y seguimiento de pedidos. | 11 | 0 |
| 13 | `tb_user_addresses` | Direcciones registradas por cada usuario. | 12 | 0 |
| 14 | `tb_users` | Usuarios de la plataforma (compradores, vendedores y personal). | 9 | 7,512 |
| 15 | `tbc_categories` | Catalogo jerarquico de categorias y subcategorias. | 7 | 100 |
| 16 | `tbc_payment_methods_types` | Tipos de metodo de pago (tarjeta, transferencia, etc.). | 6 | 0 |
| 17 | `tbd_address_components` | Componentes jerarquicos de una direccion (pais, estado, ciudad, colonia, calle). | 8 | 0 |
| 18 | `tbd_cancellation_items` | Detalle de los items cancelados. | 5 | 0 |
| 19 | `tbd_cart_items` | Productos agregados a un carrito. | 5 | 0 |
| 20 | `tbd_order_items` | Detalle de productos y cantidades de un pedido. | 9 | 0 |
| 21 | `tbd_products_categories` | Relacion muchos-a-muchos entre productos y categorias. | 5 | 17,748 |
| 22 | `tbd_products_users_providers` | Relacion producto-proveedor; identifica al vendedor de cada producto. | 7 | 7,000 |
| 23 | `tbd_return_items` | Detalle de productos devueltos. | 6 | 0 |
| 24 | `tbd_user_payment_methods` | Metodos de pago registrados por cada usuario. | 11 | 0 |
| 25 | `tbd_users_wishlist_products` | Lista de deseos de los usuarios. | 5 | 0 |

## Detalle de tablas

### `tb_carts`

Carritos de compra de los usuarios.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `user_ID` | `int` | No | UNI | NULL |  | `tb_users.ID` |
| 3 | `status` | `bit(1)` | Si |  | b'1' |  |  |
| 4 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 5 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_logs`

Bitacora de auditoria generada por los 72 triggers.  
**Registros:** 68,888

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `id` | `int` | No | PRI | NULL | auto_increment |  |
| 2 | `category_id` | `int unsigned` | Si |  | NULL |  |  |
| 3 | `product_id` | `bigint unsigned` | Si |  | NULL |  |  |
| 4 | `table_name` | `varchar(50)` | No | MUL | NULL |  |  |
| 5 | `operation` | `varchar(20)` | No |  | NULL |  |  |
| 6 | `db_user` | `varchar(100)` | No |  | NULL |  |  |
| 7 | `user_id` | `int unsigned` | Si |  | NULL |  |  |
| 8 | `record_id` | `varchar(150)` | Si |  | NULL |  |  |
| 9 | `description` | `text` | No |  | NULL |  |  |
| 10 | `operation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 11 | `operation_status` | `bit(1)` | Si |  | b'1' |  |  |

### `tb_order_cancellations`

Solicitudes de cancelacion de pedidos.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `order_ID` | `int unsigned` | No | MUL | NULL |  | `tb_orders.ID` |
| 3 | `user_ID` | `int` | No | MUL | NULL |  | `tb_users.ID` |
| 4 | `reason` | `text` | No |  | NULL |  |  |
| 5 | `cancellation_status` | `enum('Requested','Approved','Rejected')` | No |  | Requested |  |  |
| 6 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 7 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 8 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `order_ID` -> `tb_orders.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_orders`

Pedidos generados a partir de un carrito.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `buyer_ID` | `int` | No | MUL | NULL |  | `tb_users.ID` |
| 3 | `address_ID` | `bigint unsigned` | No | MUL | NULL |  | `tb_user_addresses.ID` |
| 4 | `order_number` | `varchar(50)` | No | UNI | NULL |  |  |
| 5 | `subtotal` | `decimal(12,2)` | No |  | 0.00 |  |  |
| 6 | `shipping_total` | `decimal(12,2)` | No |  | 0.00 |  |  |
| 7 | `total_amount` | `decimal(12,2)` | No |  | 0.00 |  |  |
| 8 | `order_status` | `enum('Pending','Processing','Shipped','Delivered','Cancelled')` | No |  | Pending |  |  |
| 9 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 10 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 11 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `address_ID` -> `tb_user_addresses.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `buyer_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_payment_methods`

Metodos de pago disponibles por tipo.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `payment_method_type_ID` | `int unsigned` | No | MUL | NULL |  | `tbc_payment_methods_types.ID` |
| 3 | `name` | `varchar(100)` | No |  | NULL |  |  |
| 4 | `provider` | `varchar(100)` | Si |  | NULL |  |  |
| 5 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 6 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 7 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `payment_method_type_ID` -> `tbc_payment_methods_types.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_payment_transaction`

Transacciones y respuestas de la pasarela de pago.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `payment_ID` | `int unsigned` | No | MUL | NULL |  | `tb_payments.ID` |
| 3 | `gateway_transaction_id` | `varchar(150)` | Si |  | NULL |  |  |
| 4 | `gateway_status` | `varchar(50)` | No |  | NULL |  |  |
| 5 | `gateway_response` | `json` | Si |  | NULL |  |  |
| 6 | `amount` | `decimal(12,2)` | No |  | NULL |  |  |
| 7 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |

**Llaves foraneas:**

- `payment_ID` -> `tb_payments.ID` (DELETE CASCADE, UPDATE NO ACTION)

### `tb_payments`

Pagos asociados a un pedido.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `order_ID` | `int unsigned` | No | MUL | NULL |  | `tb_orders.ID` |
| 3 | `payment_method_ID` | `int unsigned` | No | MUL | NULL |  | `tb_payment_methods.ID` |
| 4 | `amount` | `decimal(12,2)` | No |  | NULL |  |  |
| 5 | `currency` | `varchar(10)` | No |  | MXN |  |  |
| 6 | `payment_status` | `enum('Pending','Completed','Failed','Refunded')` | No |  | Pending |  |  |
| 7 | `payment_date` | `datetime` | Si |  | NULL |  |  |
| 8 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 9 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 10 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `order_ID` -> `tb_orders.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `payment_method_ID` -> `tb_payment_methods.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_people`

Datos personales y demograficos asociados a un usuario.  
**Registros:** 7,502

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `person_ID` | `bigint unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `user_ID` | `int` | Si | UNI | NULL |  | `tb_users.ID` |
| 3 | `courtesy_title` | `varchar(20)` | Si |  | NULL |  |  |
| 4 | `given_names` | `varchar(150)` | No |  | NULL |  |  |
| 5 | `family_names` | `varchar(150)` | Si |  | NULL |  |  |
| 6 | `birth_date` | `date` | Si |  | NULL |  |  |
| 7 | `gender` | `enum('Hombre','Mujer','Prefiero no decirlo')` | No |  | Prefiero no decirlo |  |  |
| 8 | `country_code` | `char(2)` | Si |  | NULL |  |  |
| 9 | `phone` | `varchar(25)` | Si |  | NULL |  |  |
| 10 | `status` | `bit(1)` | Si |  | b'1' |  |  |
| 11 | `creation_date` | `datetime` | Si |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 12 | `last_update` | `datetime` | Si |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_products`

Catalogo de productos publicados.  
**Registros:** 12,000

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `SKU` | `varchar(50)` | No | UNI | NULL |  |  |
| 3 | `name` | `varchar(250)` | No |  | NULL |  |  |
| 4 | `description` | `text` | Si |  | NULL |  |  |
| 5 | `current_price` | `decimal(10,2)` | No |  | 0.00 |  |  |
| 6 | `current_stock` | `int unsigned` | No |  | 0 |  |  |
| 7 | `status` | `bit(1)` | Si |  | b'1' |  |  |
| 8 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 9 | `last_update` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |  |

### `tb_refunds`

Reembolsos originados por devoluciones o cancelaciones.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `payment_ID` | `int unsigned` | No | MUL | NULL |  | `tb_payments.ID` |
| 3 | `return_ID` | `int unsigned` | Si | MUL | NULL |  | `tb_returns.ID` |
| 4 | `cancellation_ID` | `int unsigned` | Si | MUL | NULL |  | `tb_order_cancellations.ID` |
| 5 | `amount` | `decimal(12,2)` | No |  | NULL |  |  |
| 6 | `refund_status` | `enum('Pending','Processed','Failed')` | No |  | Pending |  |  |
| 7 | `refund_reference` | `varchar(150)` | Si |  | NULL |  |  |
| 8 | `refund_date` | `datetime` | Si |  | NULL |  |  |
| 9 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 10 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 11 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `cancellation_ID` -> `tb_order_cancellations.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `payment_ID` -> `tb_payments.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `return_ID` -> `tb_returns.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_returns`

Devoluciones solicitadas por los usuarios.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `order_ID` | `int unsigned` | No | MUL | NULL |  | `tb_orders.ID` |
| 3 | `user_ID` | `int` | No | MUL | NULL |  | `tb_users.ID` |
| 4 | `reason` | `text` | No |  | NULL |  |  |
| 5 | `return_status` | `enum('Requested','Approved','In Transit','Received','Rejected')` | No |  | Requested |  |  |
| 6 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 7 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 8 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `order_ID` -> `tb_orders.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_shipments`

Envios y seguimiento de pedidos.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `order_ID` | `int unsigned` | No | MUL | NULL |  | `tb_orders.ID` |
| 3 | `carrier` | `varchar(100)` | No |  | NULL |  |  |
| 4 | `tracking_number` | `varchar(100)` | Si |  | NULL |  |  |
| 5 | `shipment_status` | `enum('Preparing','In Transit','Out for Delivery','Delivered','Failed')` | No |  | Preparing |  |  |
| 6 | `shipped_date` | `datetime` | Si |  | NULL |  |  |
| 7 | `estimated_delivery` | `datetime` | Si |  | NULL |  |  |
| 8 | `delivered_date` | `datetime` | Si |  | NULL |  |  |
| 9 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 10 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 11 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `order_ID` -> `tb_orders.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_user_addresses`

Direcciones registradas por cada usuario.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `bigint unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `user_ID` | `int` | No | MUL | NULL |  | `tb_users.ID` |
| 3 | `address_label` | `varchar(100)` | No |  | NULL |  |  |
| 4 | `recipient_name` | `varchar(150)` | Si |  | NULL |  |  |
| 5 | `recipient_phone` | `varchar(25)` | Si |  | NULL |  |  |
| 6 | `delivery_instructions` | `varchar(500)` | Si |  | NULL |  |  |
| 7 | `latitude` | `decimal(10,7)` | Si |  | NULL |  |  |
| 8 | `longitude` | `decimal(10,7)` | Si |  | NULL |  |  |
| 9 | `is_default` | `tinyint(1)` | No |  | 0 |  |  |
| 10 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 11 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 12 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tb_users`

Usuarios de la plataforma (compradores, vendedores y personal).  
**Registros:** 7,512

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int` | No | PRI | NULL | auto_increment |  |
| 2 | `email` | `varchar(100)` | No | UNI | NULL |  |  |
| 3 | `nick` | `varchar(50)` | No | UNI | NULL |  |  |
| 4 | `roles` | `varchar(20)` | Si |  | NULL |  |  |
| 5 | `password` | `varchar(255)` | No |  | NULL |  |  |
| 6 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 7 | `last_update` | `datetime` | Si |  | NULL |  |  |
| 8 | `last_login` | `datetime` | Si |  | NULL |  |  |
| 9 | `status` | `bit(1)` | Si |  | b'1' |  |  |

### `tbc_categories`

Catalogo jerarquico de categorias y subcategorias.  
**Registros:** 100

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `id` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `name` | `varchar(120)` | Si |  | NULL |  |  |
| 3 | `description` | `text` | Si |  | NULL |  |  |
| 4 | `sup_id_category` | `int unsigned` | Si |  | NULL |  |  |
| 5 | `status` | `bit(1)` | Si |  | NULL |  |  |
| 6 | `creation_date` | `datetime` | Si |  | NULL |  |  |
| 7 | `last_update` | `datetime` | Si |  | NULL |  |  |

### `tbc_payment_methods_types`

Tipos de metodo de pago (tarjeta, transferencia, etc.).  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `code` | `varchar(30)` | No |  | NULL |  |  |
| 3 | `description` | `text` | No |  | NULL |  |  |
| 4 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 5 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 6 | `last_update` | `datetime` | Si |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |  |

### `tbd_address_components`

Componentes jerarquicos de una direccion (pais, estado, ciudad, colonia, calle).  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `bigint unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `address_ID` | `bigint unsigned` | No | MUL | NULL |  | `tbd_address_components.address_ID` |
| 3 | `value` | `varchar(255)` | No |  | NULL |  |  |
| 4 | `component_type` | `varchar(50)` | No |  | NULL |  |  |
| 5 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 6 | `address_sup_ID` | `bigint unsigned` | Si |  | NULL |  | `tbd_address_components.ID` |
| 7 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 8 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `address_ID` -> `tbd_address_components.address_ID` (DELETE RESTRICT, UPDATE NO ACTION)
- `address_sup_ID` -> `tbd_address_components.ID` (DELETE RESTRICT, UPDATE NO ACTION)

### `tbd_cancellation_items`

Detalle de los items cancelados.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `cancellation_ID` | `int unsigned` | No | MUL | NULL |  | `tb_order_cancellations.ID` |
| 3 | `order_item_ID` | `int unsigned` | No | MUL | NULL |  | `tbd_order_items.ID` |
| 4 | `quantity` | `int unsigned` | No |  | NULL |  |  |
| 5 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |

**Llaves foraneas:**

- `cancellation_ID` -> `tb_order_cancellations.ID` (DELETE CASCADE, UPDATE NO ACTION)
- `order_item_ID` -> `tbd_order_items.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tbd_cart_items`

Productos agregados a un carrito.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `cart_ID` | `int unsigned` | No | PRI | NULL |  | `tb_carts.ID` |
| 2 | `provider_ID` | `int` | No | PRI | NULL |  | `tbd_products_users_providers.user_ID` |
| 3 | `product_ID` | `int unsigned` | No | PRI | NULL |  | `tbd_products_users_providers.product_ID` |
| 4 | `quantity` | `int unsigned` | No |  | 1 |  |  |
| 5 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |

**Llaves foraneas:**

- `cart_ID` -> `tb_carts.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `product_ID` -> `tbd_products_users_providers.product_ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `provider_ID` -> `tbd_products_users_providers.user_ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tbd_order_items`

Detalle de productos y cantidades de un pedido.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `seller_order_ID` | `int unsigned` | No | MUL | NULL |  | `tb_orders.ID` |
| 3 | `product_ID` | `int unsigned` | No | MUL | NULL |  | `tbd_products_users_providers.product_ID` |
| 4 | `provider_ID` | `int` | No | MUL | NULL |  | `tbd_products_users_providers.user_ID` |
| 5 | `product_name` | `varchar(255)` | No |  | NULL |  |  |
| 6 | `quantity` | `int unsigned` | No |  | NULL |  |  |
| 7 | `unit_price` | `decimal(12,2)` | No |  | NULL |  |  |
| 8 | `subtotal` | `decimal(12,2)` | Si |  | NULL | STORED GENERATED |  |
| 9 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |

**Llaves foraneas:**

- `product_ID` -> `tbd_products_users_providers.product_ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `provider_ID` -> `tbd_products_users_providers.user_ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `seller_order_ID` -> `tb_orders.ID` (DELETE CASCADE, UPDATE CASCADE)

### `tbd_products_categories`

Relacion muchos-a-muchos entre productos y categorias.  
**Registros:** 17,748

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `product_ID` | `int unsigned` | No | PRI | NULL |  | `tb_products.ID` |
| 2 | `category_ID` | `int unsigned` | No | PRI | NULL |  | `tbc_categories.id` |
| 3 | `status` | `bit(1)` | Si |  | NULL |  |  |
| 4 | `creation_date` | `datetime` | Si |  | NULL |  |  |
| 5 | `last_update` | `datetime` | Si |  | NULL |  |  |

**Llaves foraneas:**

- `category_ID` -> `tbc_categories.id` (DELETE CASCADE, UPDATE CASCADE)
- `product_ID` -> `tb_products.ID` (DELETE CASCADE, UPDATE CASCADE)

### `tbd_products_users_providers`

Relacion producto-proveedor; identifica al vendedor de cada producto.  
**Registros:** 7,000

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `user_ID` | `int` | No | PRI | NULL |  | `tb_users.ID` |
| 2 | `product_ID` | `int unsigned` | No | PRI | NULL |  | `tb_products.ID` |
| 3 | `type_ownership` | `enum('Owner','Reseller','Distributor')` | Si |  | NULL |  |  |
| 4 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 5 | `available_date` | `datetime` | No |  | NULL |  |  |
| 6 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 7 | `last_update` | `datetime` | No |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `product_ID` -> `tb_products.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tbd_return_items`

Detalle de productos devueltos.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `int unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `return_ID` | `int unsigned` | No | MUL | NULL |  | `tb_returns.ID` |
| 3 | `order_item_ID` | `int unsigned` | No | MUL | NULL |  | `tbd_order_items.ID` |
| 4 | `quantity` | `int unsigned` | No |  | NULL |  |  |
| 5 | `condition_notes` | `varchar(255)` | Si |  | NULL |  |  |
| 6 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |

**Llaves foraneas:**

- `order_item_ID` -> `tbd_order_items.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `return_ID` -> `tb_returns.ID` (DELETE CASCADE, UPDATE NO ACTION)

### `tbd_user_payment_methods`

Metodos de pago registrados por cada usuario.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `ID` | `bigint unsigned` | No | PRI | NULL | auto_increment |  |
| 2 | `user_ID` | `int` | No | MUL | NULL |  | `tb_users.ID` |
| 3 | `payment_method_type_ID` | `int unsigned` | No | MUL | NULL |  | `tbc_payment_methods_types.ID` |
| 4 | `provider` | `varchar(60)` | No | MUL | NULL |  |  |
| 5 | `provider_method_ref` | `varchar(255)` | No |  | NULL |  |  |
| 6 | `label` | `varchar(100)` | Si |  | NULL |  |  |
| 7 | `last_four` | `char(4)` | Si |  | NULL |  |  |
| 8 | `is_default` | `tinyint(1)` | No |  | 0 |  |  |
| 9 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 10 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 11 | `last_update` | `datetime` | Si |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `payment_method_type_ID` -> `tbc_payment_methods_types.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

### `tbd_users_wishlist_products`

Lista de deseos de los usuarios.  
**Registros:** 0

| No. | Columna | Tipo | Nulo | Llave | Default | Extra | FK |
|-----|---------|------|------|-------|---------|-------|----|
| 1 | `user_ID` | `int` | No | PRI | NULL |  | `tb_users.ID` |
| 2 | `product_ID` | `int unsigned` | No | PRI | NULL |  | `tb_products.ID` |
| 3 | `status` | `bit(1)` | No |  | b'1' |  |  |
| 4 | `creation_date` | `datetime` | No |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |  |
| 5 | `last_update` | `datetime` | No |  | NULL | on update CURRENT_TIMESTAMP |  |

**Llaves foraneas:**

- `product_ID` -> `tb_products.ID` (DELETE NO ACTION, UPDATE NO ACTION)
- `user_ID` -> `tb_users.ID` (DELETE NO ACTION, UPDATE NO ACTION)

## Vistas

| # | Vista | Proposito |
|---|-------|-----------|
| 1 | `vw_productos_por_categoria` | Catalogo agregado de productos por categoria. |
| 2 | `vw_trazabilidad_address_components` | Vista de trazabilidad de la tabla tb_address_components |
| 3 | `vw_trazabilidad_cancellation_items` | Vista de trazabilidad de la tabla tb_cancellation_items |
| 4 | `vw_trazabilidad_cart_items` | Vista de trazabilidad de la tabla tb_cart_items |
| 5 | `vw_trazabilidad_carts` | Vista de trazabilidad de la tabla tb_carts |
| 6 | `vw_trazabilidad_categorias` | Vista de trazabilidad de la tabla tb_categorias |
| 7 | `vw_trazabilidad_order_cancellations` | Vista de trazabilidad de la tabla tb_order_cancellations |
| 8 | `vw_trazabilidad_order_items` | Vista de trazabilidad de la tabla tb_order_items |
| 9 | `vw_trazabilidad_orders` | Vista de trazabilidad de la tabla tb_orders |
| 10 | `vw_trazabilidad_payment_methods` | Vista de trazabilidad de la tabla tb_payment_methods |
| 11 | `vw_trazabilidad_payment_methods_types` | Vista de trazabilidad de la tabla tb_payment_methods_types |
| 12 | `vw_trazabilidad_payment_transaction` | Vista de trazabilidad de la tabla tb_payment_transaction |
| 13 | `vw_trazabilidad_payments` | Vista de trazabilidad de la tabla tb_payments |
| 14 | `vw_trazabilidad_people` | Vista de trazabilidad de la tabla tb_people |
| 15 | `vw_trazabilidad_productos` | Vista de trazabilidad de la tabla tb_productos |
| 16 | `vw_trazabilidad_productos_categorias` | Vista de trazabilidad de la tabla tb_productos_categorias |
| 17 | `vw_trazabilidad_products_users_providers` | Vista de trazabilidad de la tabla tb_products_users_providers |
| 18 | `vw_trazabilidad_refunds` | Vista de trazabilidad de la tabla tb_refunds |
| 19 | `vw_trazabilidad_return_items` | Vista de trazabilidad de la tabla tb_return_items |
| 20 | `vw_trazabilidad_returns` | Vista de trazabilidad de la tabla tb_returns |
| 21 | `vw_trazabilidad_shipments` | Vista de trazabilidad de la tabla tb_shipments |
| 22 | `vw_trazabilidad_user_addresses` | Vista de trazabilidad de la tabla tb_user_addresses |
| 23 | `vw_trazabilidad_user_payment_methods` | Vista de trazabilidad de la tabla tb_user_payment_methods |
| 24 | `vw_trazabilidad_users_wishlist_products` | Vista de trazabilidad de la tabla tb_users_wishlist_products |
| 25 | `vw_trazabilidad_usuarios` | Trazabilidad de usuarios (sin password). |
