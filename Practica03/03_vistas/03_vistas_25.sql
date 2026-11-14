-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 3: 25 vistas SQL
--   - 24 vistas de trazabilidad (una por tabla operativa)
--   - 1 vista de Productos por Categoria
-- Las vistas usan LEFT JOIN con tb_logs para no perder
-- registros que aun no tengan eventos de auditoria.
-- ============================================================
USE db_test;

DROP VIEW IF EXISTS vw_total_products_by_category;
DROP VIEW IF EXISTS vw_productos_por_categoria;
DROP VIEW IF EXISTS `vw_trazabilidad_carts`;
DROP VIEW IF EXISTS `vw_trazabilidad_order_cancellations`;
DROP VIEW IF EXISTS `vw_trazabilidad_orders`;
DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods`;
DROP VIEW IF EXISTS `vw_trazabilidad_payment_transaction`;
DROP VIEW IF EXISTS `vw_trazabilidad_payments`;
DROP VIEW IF EXISTS `vw_trazabilidad_people`;
DROP VIEW IF EXISTS `vw_trazabilidad_productos`;
DROP VIEW IF EXISTS `vw_trazabilidad_refunds`;
DROP VIEW IF EXISTS `vw_trazabilidad_returns`;
DROP VIEW IF EXISTS `vw_trazabilidad_shipments`;
DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`;
DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`;
DROP VIEW IF EXISTS `vw_trazabilidad_categorias`;
DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`;
DROP VIEW IF EXISTS `vw_trazabilidad_address_components`;
DROP VIEW IF EXISTS `vw_trazabilidad_cancellation_items`;
DROP VIEW IF EXISTS `vw_trazabilidad_cart_items`;
DROP VIEW IF EXISTS `vw_trazabilidad_order_items`;
DROP VIEW IF EXISTS `vw_trazabilidad_productos_categorias`;
DROP VIEW IF EXISTS `vw_trazabilidad_products_users_providers`;
DROP VIEW IF EXISTS `vw_trazabilidad_return_items`;
DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`;
DROP VIEW IF EXISTS `vw_trazabilidad_users_wishlist_products`;

-- ------------------------------------------------------------
-- Trazabilidad de tb_carts
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_carts` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_carts` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_carts'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_order_cancellations
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_order_cancellations` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_order_cancellations` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_order_cancellations'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_orders
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_orders` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_orders` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_orders'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_payment_methods
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_payment_methods` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_payment_methods` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_payment_methods'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_payment_transaction
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_payment_transaction` AS
SELECT
    t.ID,
    t.payment_ID,
    t.gateway_transaction_id,
    t.gateway_status,
    t.amount,
    t.creation_date,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_payment_transaction` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_payment_transaction'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_payments
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_payments` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_payments` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_payments'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_people
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_people` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_people` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_people'
      AND l.record_id  = CAST(t.person_ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_products
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_productos` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_products` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_products'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_refunds
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_refunds` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_refunds` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_refunds'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_returns
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_returns` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_returns` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_returns'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_shipments
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_shipments` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_shipments` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_shipments'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_user_addresses
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_user_addresses` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_user_addresses` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_user_addresses'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tb_users
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_usuarios` AS
SELECT
    t.ID,
    t.email,
    t.nick              AS username,
    t.roles,
    t.creation_date,
    t.last_update,
    t.last_login,
    t.status,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tb_users` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tb_users'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbc_categories
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_categorias` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbc_categories` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbc_categories'
      AND l.record_id  = CAST(t.id AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbc_payment_methods_types
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_payment_methods_types` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbc_payment_methods_types` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbc_payment_methods_types'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_address_components
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_address_components` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_address_components` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_address_components'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_cancellation_items
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_cancellation_items` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_cancellation_items` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_cancellation_items'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_cart_items
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_cart_items` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_cart_items` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_cart_items'
      AND l.record_id  = CAST(CONCAT(t.cart_ID, '-', t.provider_ID, '-', t.product_ID) AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_order_items
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_order_items` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_order_items` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_order_items'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_products_categories
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_productos_categorias` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_products_categories` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_products_categories'
      AND l.record_id  = CAST(CONCAT(t.product_ID, '-', t.category_ID) AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_products_users_providers
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_products_users_providers` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_products_users_providers` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_products_users_providers'
      AND l.record_id  = CAST(CONCAT(t.user_ID, '-', t.product_ID) AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_return_items
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_return_items` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_return_items` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_return_items'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_user_payment_methods
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_user_payment_methods` AS
SELECT
    t.ID,
    t.user_ID,
    t.payment_method_type_ID,
    t.provider,
    CONCAT('****', RIGHT(t.provider_method_ref, 4)) AS provider_method_ref,
    t.label,
    t.last_four,
    t.is_default,
    t.status,
    t.creation_date,
    t.last_update,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_user_payment_methods` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_user_payment_methods'
      AND l.record_id  = CAST(t.ID AS CHAR)
;

-- ------------------------------------------------------------
-- Trazabilidad de tbd_users_wishlist_products
-- ------------------------------------------------------------
CREATE VIEW `vw_trazabilidad_users_wishlist_products` AS
SELECT
    t.*,
    l.id                AS log_id,
    l.operation         AS log_operation,
    l.db_user           AS log_db_user,
    l.record_id         AS log_record_id,
    l.description       AS log_description,
    l.operation_date    AS log_date,
    l.operation_status  AS log_status
FROM `tbd_users_wishlist_products` t
LEFT JOIN tb_logs l
       ON l.table_name = 'tbd_users_wishlist_products'
      AND l.record_id  = CAST(CONCAT(t.user_ID, '-', t.product_ID) AS CHAR)
;

-- ------------------------------------------------------------
-- Vista 25: Productos por Categoria y Subcategoria
-- Incluye clasificacion jerarquica, cantidades, stock,
-- precios y estados de disponibilidad.
-- ------------------------------------------------------------
CREATE VIEW `vw_productos_por_categoria` AS
SELECT
    c.id                                          AS category_id,
    c.name                                        AS category_name,
    c.sup_id_category                             AS parent_category_id,
    pc.name                                       AS parent_category_name,
    CASE
        WHEN c.sup_id_category IS NULL THEN 'Categoria'
        ELSE 'Subcategoria'
    END                                           AS category_level,
    c.status+0                                    AS category_status,
    COUNT(DISTINCT p.ID)                          AS total_products,
    SUM(CASE WHEN p.status = b'1' THEN 1 ELSE 0 END) AS active_products,
    SUM(CASE WHEN p.status = b'0' THEN 1 ELSE 0 END) AS discontinued_products,
    COALESCE(SUM(p.current_stock), 0)             AS total_stock,
    COALESCE(MIN(p.current_price), 0)             AS min_price,
    COALESCE(MAX(p.current_price), 0)             AS max_price,
    COALESCE(ROUND(AVG(p.current_price), 2), 0)   AS avg_price
FROM tbc_categories c
LEFT JOIN tbc_categories pc
       ON pc.id = c.sup_id_category
LEFT JOIN tbd_products_categories pcat
       ON pcat.category_ID = c.id
      AND pcat.status = b'1'
LEFT JOIN tb_products p
       ON p.ID = pcat.product_ID
GROUP BY
    c.id, c.name, c.sup_id_category, pc.name, c.status
;

-- ------------------------------------------------------------
-- Verificacion: deben existir 25 vistas.
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_vistas
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'db_test';

SELECT TABLE_NAME AS vista
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'db_test'
ORDER BY TABLE_NAME;
