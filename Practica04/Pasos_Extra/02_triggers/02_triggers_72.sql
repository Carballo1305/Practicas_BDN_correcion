-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 2: 72 triggers de auditoria
-- 24 tablas operativas x 3 eventos (INSERT, UPDATE, DELETE)
-- La tabla tb_logs NO tiene triggers (es la bitacora).
-- ============================================================
USE db_test;

-- ------------------------------------------------------------
-- Eliminar los triggers de la version anterior y los de esta
-- version para reconstruirlos de forma homogenea.
-- ------------------------------------------------------------
DROP TRIGGER IF EXISTS `trg_categories_after_delete`;
DROP TRIGGER IF EXISTS `trg_categories_after_insert`;
DROP TRIGGER IF EXISTS `trg_categories_after_update`;
DROP TRIGGER IF EXISTS `trg_products_after_delete`;
DROP TRIGGER IF EXISTS `trg_products_after_insert`;
DROP TRIGGER IF EXISTS `trg_products_after_update`;
DROP TRIGGER IF EXISTS `trg_products_categorias_after_delete`;
DROP TRIGGER IF EXISTS `trg_products_categorias_after_insert`;
DROP TRIGGER IF EXISTS `trg_products_categorias_after_update`;
DROP TRIGGER IF EXISTS `trg_tbc_payment_methods_types_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbc_payment_methods_types_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbc_payment_methods_types_after_update`;
DROP TRIGGER IF EXISTS `trg_tbd_address_components_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbd_address_components_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbd_address_components_after_update`;
DROP TRIGGER IF EXISTS `trg_tbd_carts_items_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbd_carts_items_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbd_carts_items_after_update`;
DROP TRIGGER IF EXISTS `trg_tbd_order_items_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbd_order_items_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbd_order_items_after_update`;
DROP TRIGGER IF EXISTS `trg_tbd_products_users_providers_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbd_products_users_providers_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbd_products_users_providers_after_update`;
DROP TRIGGER IF EXISTS `trg_tbd_users_wishlist_products_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbd_users_wishlist_products_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbd_users_wishlist_products_after_update`;
DROP TRIGGER IF EXISTS `trg_tbd_user_payment_methods_after_delete`;
DROP TRIGGER IF EXISTS `trg_tbd_user_payment_methods_after_insert`;
DROP TRIGGER IF EXISTS `trg_tbd_user_payment_methods_after_update`;
DROP TRIGGER IF EXISTS `trg_tb_carts_after_delete`;
DROP TRIGGER IF EXISTS `trg_tb_carts_after_insert`;
DROP TRIGGER IF EXISTS `trg_tb_carts_after_update`;
DROP TRIGGER IF EXISTS `trg_tb_people_after_delete`;
DROP TRIGGER IF EXISTS `trg_tb_people_after_insert`;
DROP TRIGGER IF EXISTS `trg_tb_people_after_update`;
DROP TRIGGER IF EXISTS `trg_tb_user_addresses_after_delete`;
DROP TRIGGER IF EXISTS `trg_tb_user_addresses_after_insert`;
DROP TRIGGER IF EXISTS `trg_tb_user_addresses_after_update`;
DROP TRIGGER IF EXISTS `trg_users_after_delete`;
DROP TRIGGER IF EXISTS `trg_users_after_insert`;
DROP TRIGGER IF EXISTS `trg_users_after_update`;

-- tb_carts / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_carts_ai`;
CREATE TRIGGER `trg_tb_carts_ai` AFTER INSERT ON `tb_carts`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_carts', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_carts: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_carts / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_carts_au`;
CREATE TRIGGER `trg_tb_carts_au` AFTER UPDATE ON `tb_carts`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_carts', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_carts: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_carts / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_carts_ad`;
CREATE TRIGGER `trg_tb_carts_ad` AFTER DELETE ON `tb_carts`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_carts', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_carts: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_order_cancellations / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_order_cancellations_ai`;
CREATE TRIGGER `trg_tb_order_cancellations_ai` AFTER INSERT ON `tb_order_cancellations`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_order_cancellations', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_order_cancellations: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('cancellation_status=', IFNULL(NEW.`cancellation_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_order_cancellations / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_order_cancellations_au`;
CREATE TRIGGER `trg_tb_order_cancellations_au` AFTER UPDATE ON `tb_order_cancellations`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_order_cancellations', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_order_cancellations: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('cancellation_status (antes)=', IFNULL(OLD.`cancellation_status`, 'NULL'), '; cancellation_status (despues)=', IFNULL(NEW.`cancellation_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_order_cancellations / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_order_cancellations_ad`;
CREATE TRIGGER `trg_tb_order_cancellations_ad` AFTER DELETE ON `tb_order_cancellations`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_order_cancellations', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_order_cancellations: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('cancellation_status=', IFNULL(OLD.`cancellation_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_orders / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_orders_ai`;
CREATE TRIGGER `trg_tb_orders_ai` AFTER INSERT ON `tb_orders`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_orders', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.buyer_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_orders: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('buyer_ID=', IFNULL(NEW.`buyer_ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('order_number=', IFNULL(NEW.`order_number`, 'NULL')), '; ', CONCAT('total_amount=', IFNULL(NEW.`total_amount`, 'NULL')), '; ', CONCAT('order_status=', IFNULL(NEW.`order_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_orders / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_orders_au`;
CREATE TRIGGER `trg_tb_orders_au` AFTER UPDATE ON `tb_orders`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_orders', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.buyer_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_orders: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('buyer_ID (antes)=', IFNULL(OLD.`buyer_ID`, 'NULL'), '; buyer_ID (despues)=', IFNULL(NEW.`buyer_ID`, 'NULL')), '; ', CONCAT('address_ID (antes)=', IFNULL(OLD.`address_ID`, 'NULL'), '; address_ID (despues)=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('order_number (antes)=', IFNULL(OLD.`order_number`, 'NULL'), '; order_number (despues)=', IFNULL(NEW.`order_number`, 'NULL')), '; ', CONCAT('total_amount (antes)=', IFNULL(OLD.`total_amount`, 'NULL'), '; total_amount (despues)=', IFNULL(NEW.`total_amount`, 'NULL')), '; ', CONCAT('order_status (antes)=', IFNULL(OLD.`order_status`, 'NULL'), '; order_status (despues)=', IFNULL(NEW.`order_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_orders / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_orders_ad`;
CREATE TRIGGER `trg_tb_orders_ad` AFTER DELETE ON `tb_orders`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_orders', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.buyer_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_orders: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('buyer_ID=', IFNULL(OLD.`buyer_ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(OLD.`address_ID`, 'NULL')), '; ', CONCAT('order_number=', IFNULL(OLD.`order_number`, 'NULL')), '; ', CONCAT('total_amount=', IFNULL(OLD.`total_amount`, 'NULL')), '; ', CONCAT('order_status=', IFNULL(OLD.`order_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payment_methods / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_payment_methods_ai`;
CREATE TRIGGER `trg_tb_payment_methods_ai` AFTER INSERT ON `tb_payment_methods`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_methods', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('name=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('provider=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payment_methods / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_payment_methods_au`;
CREATE TRIGGER `trg_tb_payment_methods_au` AFTER UPDATE ON `tb_payment_methods`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_methods', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_payment_methods: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID (antes)=', IFNULL(OLD.`payment_method_type_ID`, 'NULL'), '; payment_method_type_ID (despues)=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('name (antes)=', IFNULL(OLD.`name`, 'NULL'), '; name (despues)=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('provider (antes)=', IFNULL(OLD.`provider`, 'NULL'), '; provider (despues)=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payment_methods / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_payment_methods_ad`;
CREATE TRIGGER `trg_tb_payment_methods_ad` AFTER DELETE ON `tb_payment_methods`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_methods', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(OLD.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('name=', IFNULL(OLD.`name`, 'NULL')), '; ', CONCAT('provider=', IFNULL(OLD.`provider`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payment_transaction / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_payment_transaction_ai`;
CREATE TRIGGER `trg_tb_payment_transaction_ai` AFTER INSERT ON `tb_payment_transaction`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_transaction', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_payment_transaction: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('gateway_status=', IFNULL(NEW.`gateway_status`, 'NULL')), '; ', CONCAT('amount=', IFNULL(NEW.`amount`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payment_transaction / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_payment_transaction_au`;
CREATE TRIGGER `trg_tb_payment_transaction_au` AFTER UPDATE ON `tb_payment_transaction`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_transaction', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_payment_transaction: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID (antes)=', IFNULL(OLD.`payment_ID`, 'NULL'), '; payment_ID (despues)=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('gateway_status (antes)=', IFNULL(OLD.`gateway_status`, 'NULL'), '; gateway_status (despues)=', IFNULL(NEW.`gateway_status`, 'NULL')), '; ', CONCAT('amount (antes)=', IFNULL(OLD.`amount`, 'NULL'), '; amount (despues)=', IFNULL(NEW.`amount`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payment_transaction / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_payment_transaction_ad`;
CREATE TRIGGER `trg_tb_payment_transaction_ad` AFTER DELETE ON `tb_payment_transaction`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payment_transaction', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_payment_transaction: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(OLD.`payment_ID`, 'NULL')), '; ', CONCAT('gateway_status=', IFNULL(OLD.`gateway_status`, 'NULL')), '; ', CONCAT('amount=', IFNULL(OLD.`amount`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payments / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_payments_ai`;
CREATE TRIGGER `trg_tb_payments_ai` AFTER INSERT ON `tb_payments`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payments', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_payments: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('payment_method_ID=', IFNULL(NEW.`payment_method_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('payment_status=', IFNULL(NEW.`payment_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payments / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_payments_au`;
CREATE TRIGGER `trg_tb_payments_au` AFTER UPDATE ON `tb_payments`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payments', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_payments: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('payment_method_ID (antes)=', IFNULL(OLD.`payment_method_ID`, 'NULL'), '; payment_method_ID (despues)=', IFNULL(NEW.`payment_method_ID`, 'NULL')), '; ', CONCAT('amount (antes)=', IFNULL(OLD.`amount`, 'NULL'), '; amount (despues)=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('payment_status (antes)=', IFNULL(OLD.`payment_status`, 'NULL'), '; payment_status (despues)=', IFNULL(NEW.`payment_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_payments / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_payments_ad`;
CREATE TRIGGER `trg_tb_payments_ad` AFTER DELETE ON `tb_payments`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_payments', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_payments: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('payment_method_ID=', IFNULL(OLD.`payment_method_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(OLD.`amount`, 'NULL')), '; ', CONCAT('payment_status=', IFNULL(OLD.`payment_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_people / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_people_ai`;
CREATE TRIGGER `trg_tb_people_ai` AFTER INSERT ON `tb_people`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_people', 'INSERT', USER(), CAST(NEW.`person_ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_people: ', CONCAT(CONCAT('person_ID=', IFNULL(NEW.`person_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('given_names=', IFNULL(NEW.`given_names`, 'NULL')), '; ', CONCAT('family_names=', IFNULL(NEW.`family_names`, 'NULL')), '; ', CONCAT('birth_date=', IFNULL(NEW.`birth_date`, 'NULL')), '; ', CONCAT('gender=', IFNULL(NEW.`gender`, 'NULL')), '; ', CONCAT('country_code=', IFNULL(NEW.`country_code`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_people / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_people_au`;
CREATE TRIGGER `trg_tb_people_au` AFTER UPDATE ON `tb_people`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_people', 'UPDATE', USER(), CAST(NEW.`person_ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_people: ', CONCAT(CONCAT('person_ID (antes)=', IFNULL(OLD.`person_ID`, 'NULL'), '; person_ID (despues)=', IFNULL(NEW.`person_ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('given_names (antes)=', IFNULL(OLD.`given_names`, 'NULL'), '; given_names (despues)=', IFNULL(NEW.`given_names`, 'NULL')), '; ', CONCAT('family_names (antes)=', IFNULL(OLD.`family_names`, 'NULL'), '; family_names (despues)=', IFNULL(NEW.`family_names`, 'NULL')), '; ', CONCAT('birth_date (antes)=', IFNULL(OLD.`birth_date`, 'NULL'), '; birth_date (despues)=', IFNULL(NEW.`birth_date`, 'NULL')), '; ', CONCAT('gender (antes)=', IFNULL(OLD.`gender`, 'NULL'), '; gender (despues)=', IFNULL(NEW.`gender`, 'NULL')), '; ', CONCAT('country_code (antes)=', IFNULL(OLD.`country_code`, 'NULL'), '; country_code (despues)=', IFNULL(NEW.`country_code`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_people / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_people_ad`;
CREATE TRIGGER `trg_tb_people_ad` AFTER DELETE ON `tb_people`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_people', 'DELETE', USER(), CAST(OLD.`person_ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_people: ', CONCAT(CONCAT('person_ID=', IFNULL(OLD.`person_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('given_names=', IFNULL(OLD.`given_names`, 'NULL')), '; ', CONCAT('family_names=', IFNULL(OLD.`family_names`, 'NULL')), '; ', CONCAT('birth_date=', IFNULL(OLD.`birth_date`, 'NULL')), '; ', CONCAT('gender=', IFNULL(OLD.`gender`, 'NULL')), '; ', CONCAT('country_code=', IFNULL(OLD.`country_code`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_products / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_products_ai`;
CREATE TRIGGER `trg_tb_products_ai` AFTER INSERT ON `tb_products`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_products', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NEW.ID,
    NULL,
    CONCAT('INSERT en tb_products: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('SKU=', IFNULL(NEW.`SKU`, 'NULL')), '; ', CONCAT('name=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('current_price=', IFNULL(NEW.`current_price`, 'NULL')), '; ', CONCAT('current_stock=', IFNULL(NEW.`current_stock`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_products / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_products_au`;
CREATE TRIGGER `trg_tb_products_au` AFTER UPDATE ON `tb_products`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_products', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NEW.ID,
    NULL,
    CONCAT('UPDATE en tb_products: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('SKU (antes)=', IFNULL(OLD.`SKU`, 'NULL'), '; SKU (despues)=', IFNULL(NEW.`SKU`, 'NULL')), '; ', CONCAT('name (antes)=', IFNULL(OLD.`name`, 'NULL'), '; name (despues)=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('current_price (antes)=', IFNULL(OLD.`current_price`, 'NULL'), '; current_price (despues)=', IFNULL(NEW.`current_price`, 'NULL')), '; ', CONCAT('current_stock (antes)=', IFNULL(OLD.`current_stock`, 'NULL'), '; current_stock (despues)=', IFNULL(NEW.`current_stock`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_products / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_products_ad`;
CREATE TRIGGER `trg_tb_products_ad` AFTER DELETE ON `tb_products`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_products', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    OLD.ID,
    NULL,
    CONCAT('DELETE en tb_products: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('SKU=', IFNULL(OLD.`SKU`, 'NULL')), '; ', CONCAT('name=', IFNULL(OLD.`name`, 'NULL')), '; ', CONCAT('current_price=', IFNULL(OLD.`current_price`, 'NULL')), '; ', CONCAT('current_stock=', IFNULL(OLD.`current_stock`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_refunds / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_refunds_ai`;
CREATE TRIGGER `trg_tb_refunds_ai` AFTER INSERT ON `tb_refunds`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_refunds', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_refunds: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('refund_status=', IFNULL(NEW.`refund_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_refunds / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_refunds_au`;
CREATE TRIGGER `trg_tb_refunds_au` AFTER UPDATE ON `tb_refunds`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_refunds', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_refunds: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('payment_ID (antes)=', IFNULL(OLD.`payment_ID`, 'NULL'), '; payment_ID (despues)=', IFNULL(NEW.`payment_ID`, 'NULL')), '; ', CONCAT('return_ID (antes)=', IFNULL(OLD.`return_ID`, 'NULL'), '; return_ID (despues)=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('cancellation_ID (antes)=', IFNULL(OLD.`cancellation_ID`, 'NULL'), '; cancellation_ID (despues)=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('amount (antes)=', IFNULL(OLD.`amount`, 'NULL'), '; amount (despues)=', IFNULL(NEW.`amount`, 'NULL')), '; ', CONCAT('refund_status (antes)=', IFNULL(OLD.`refund_status`, 'NULL'), '; refund_status (despues)=', IFNULL(NEW.`refund_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_refunds / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_refunds_ad`;
CREATE TRIGGER `trg_tb_refunds_ad` AFTER DELETE ON `tb_refunds`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_refunds', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_refunds: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('payment_ID=', IFNULL(OLD.`payment_ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(OLD.`return_ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(OLD.`cancellation_ID`, 'NULL')), '; ', CONCAT('amount=', IFNULL(OLD.`amount`, 'NULL')), '; ', CONCAT('refund_status=', IFNULL(OLD.`refund_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_returns / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_returns_ai`;
CREATE TRIGGER `trg_tb_returns_ai` AFTER INSERT ON `tb_returns`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_returns', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_returns: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('return_status=', IFNULL(NEW.`return_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_returns / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_returns_au`;
CREATE TRIGGER `trg_tb_returns_au` AFTER UPDATE ON `tb_returns`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_returns', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_returns: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('return_status (antes)=', IFNULL(OLD.`return_status`, 'NULL'), '; return_status (despues)=', IFNULL(NEW.`return_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_returns / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_returns_ad`;
CREATE TRIGGER `trg_tb_returns_ad` AFTER DELETE ON `tb_returns`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_returns', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_returns: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('return_status=', IFNULL(OLD.`return_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_shipments / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_shipments_ai`;
CREATE TRIGGER `trg_tb_shipments_ai` AFTER INSERT ON `tb_shipments`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_shipments', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tb_shipments: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('carrier=', IFNULL(NEW.`carrier`, 'NULL')), '; ', CONCAT('tracking_number=', IFNULL(NEW.`tracking_number`, 'NULL')), '; ', CONCAT('shipment_status=', IFNULL(NEW.`shipment_status`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_shipments / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_shipments_au`;
CREATE TRIGGER `trg_tb_shipments_au` AFTER UPDATE ON `tb_shipments`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_shipments', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_shipments: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('order_ID (antes)=', IFNULL(OLD.`order_ID`, 'NULL'), '; order_ID (despues)=', IFNULL(NEW.`order_ID`, 'NULL')), '; ', CONCAT('carrier (antes)=', IFNULL(OLD.`carrier`, 'NULL'), '; carrier (despues)=', IFNULL(NEW.`carrier`, 'NULL')), '; ', CONCAT('tracking_number (antes)=', IFNULL(OLD.`tracking_number`, 'NULL'), '; tracking_number (despues)=', IFNULL(NEW.`tracking_number`, 'NULL')), '; ', CONCAT('shipment_status (antes)=', IFNULL(OLD.`shipment_status`, 'NULL'), '; shipment_status (despues)=', IFNULL(NEW.`shipment_status`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_shipments / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_shipments_ad`;
CREATE TRIGGER `trg_tb_shipments_ad` AFTER DELETE ON `tb_shipments`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_shipments', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tb_shipments: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('order_ID=', IFNULL(OLD.`order_ID`, 'NULL')), '; ', CONCAT('carrier=', IFNULL(OLD.`carrier`, 'NULL')), '; ', CONCAT('tracking_number=', IFNULL(OLD.`tracking_number`, 'NULL')), '; ', CONCAT('shipment_status=', IFNULL(OLD.`shipment_status`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_user_addresses / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_user_addresses_ai`;
CREATE TRIGGER `trg_tb_user_addresses_ai` AFTER INSERT ON `tb_user_addresses`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_user_addresses', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_user_addresses: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('address_label=', IFNULL(NEW.`address_label`, 'NULL')), '; ', CONCAT('recipient_name=', IFNULL(NEW.`recipient_name`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_user_addresses / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_user_addresses_au`;
CREATE TRIGGER `trg_tb_user_addresses_au` AFTER UPDATE ON `tb_user_addresses`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_user_addresses', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_user_addresses: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('address_label (antes)=', IFNULL(OLD.`address_label`, 'NULL'), '; address_label (despues)=', IFNULL(NEW.`address_label`, 'NULL')), '; ', CONCAT('recipient_name (antes)=', IFNULL(OLD.`recipient_name`, 'NULL'), '; recipient_name (despues)=', IFNULL(NEW.`recipient_name`, 'NULL')), '; ', CONCAT('is_default (antes)=', IFNULL(OLD.`is_default`, 'NULL'), '; is_default (despues)=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_user_addresses / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_user_addresses_ad`;
CREATE TRIGGER `trg_tb_user_addresses_ad` AFTER DELETE ON `tb_user_addresses`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_user_addresses', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_user_addresses: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('address_label=', IFNULL(OLD.`address_label`, 'NULL')), '; ', CONCAT('recipient_name=', IFNULL(OLD.`recipient_name`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(OLD.`is_default`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_users / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tb_users_ai`;
CREATE TRIGGER `trg_tb_users_ai` AFTER INSERT ON `tb_users`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_users', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.ID,
    NULL,
    NULL,
    CONCAT('INSERT en tb_users: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('email=', IFNULL(NEW.`email`, 'NULL')), '; ', CONCAT('nick=', IFNULL(NEW.`nick`, 'NULL')), '; ', CONCAT('roles=', IFNULL(NEW.`roles`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_users / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tb_users_au`;
CREATE TRIGGER `trg_tb_users_au` AFTER UPDATE ON `tb_users`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_users', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tb_users: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('email (antes)=', IFNULL(OLD.`email`, 'NULL'), '; email (despues)=', IFNULL(NEW.`email`, 'NULL')), '; ', CONCAT('nick (antes)=', IFNULL(OLD.`nick`, 'NULL'), '; nick (despues)=', IFNULL(NEW.`nick`, 'NULL')), '; ', CONCAT('roles (antes)=', IFNULL(OLD.`roles`, 'NULL'), '; roles (despues)=', IFNULL(NEW.`roles`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tb_users / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tb_users_ad`;
CREATE TRIGGER `trg_tb_users_ad` AFTER DELETE ON `tb_users`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tb_users', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.ID,
    NULL,
    NULL,
    CONCAT('DELETE en tb_users: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('email=', IFNULL(OLD.`email`, 'NULL')), '; ', CONCAT('nick=', IFNULL(OLD.`nick`, 'NULL')), '; ', CONCAT('roles=', IFNULL(OLD.`roles`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbc_categories / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbc_categories_ai`;
CREATE TRIGGER `trg_tbc_categories_ai` AFTER INSERT ON `tbc_categories`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_categories', 'INSERT', USER(), CAST(NEW.`id` AS CHAR),
    NULL,
    NULL,
    NEW.id,
    CONCAT('INSERT en tbc_categories: ', CONCAT(CONCAT('id=', IFNULL(NEW.`id`, 'NULL')), '; ', CONCAT('name=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('sup_id_category=', IFNULL(NEW.`sup_id_category`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbc_categories / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbc_categories_au`;
CREATE TRIGGER `trg_tbc_categories_au` AFTER UPDATE ON `tbc_categories`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_categories', 'UPDATE', USER(), CAST(NEW.`id` AS CHAR),
    NULL,
    NULL,
    NEW.id,
    CONCAT('UPDATE en tbc_categories: ', CONCAT(CONCAT('id (antes)=', IFNULL(OLD.`id`, 'NULL'), '; id (despues)=', IFNULL(NEW.`id`, 'NULL')), '; ', CONCAT('name (antes)=', IFNULL(OLD.`name`, 'NULL'), '; name (despues)=', IFNULL(NEW.`name`, 'NULL')), '; ', CONCAT('sup_id_category (antes)=', IFNULL(OLD.`sup_id_category`, 'NULL'), '; sup_id_category (despues)=', IFNULL(NEW.`sup_id_category`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbc_categories / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbc_categories_ad`;
CREATE TRIGGER `trg_tbc_categories_ad` AFTER DELETE ON `tbc_categories`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_categories', 'DELETE', USER(), CAST(OLD.`id` AS CHAR),
    NULL,
    NULL,
    OLD.id,
    CONCAT('DELETE en tbc_categories: ', CONCAT(CONCAT('id=', IFNULL(OLD.`id`, 'NULL')), '; ', CONCAT('name=', IFNULL(OLD.`name`, 'NULL')), '; ', CONCAT('sup_id_category=', IFNULL(OLD.`sup_id_category`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbc_payment_methods_types / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbc_payment_methods_types_ai`;
CREATE TRIGGER `trg_tbc_payment_methods_types_ai` AFTER INSERT ON `tbc_payment_methods_types`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_payment_methods_types', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbc_payment_methods_types: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('code=', IFNULL(NEW.`code`, 'NULL')), '; ', CONCAT('description=', IFNULL(NEW.`description`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbc_payment_methods_types / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbc_payment_methods_types_au`;
CREATE TRIGGER `trg_tbc_payment_methods_types_au` AFTER UPDATE ON `tbc_payment_methods_types`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_payment_methods_types', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbc_payment_methods_types: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('code (antes)=', IFNULL(OLD.`code`, 'NULL'), '; code (despues)=', IFNULL(NEW.`code`, 'NULL')), '; ', CONCAT('description (antes)=', IFNULL(OLD.`description`, 'NULL'), '; description (despues)=', IFNULL(NEW.`description`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbc_payment_methods_types / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbc_payment_methods_types_ad`;
CREATE TRIGGER `trg_tbc_payment_methods_types_ad` AFTER DELETE ON `tbc_payment_methods_types`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbc_payment_methods_types', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbc_payment_methods_types: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('code=', IFNULL(OLD.`code`, 'NULL')), '; ', CONCAT('description=', IFNULL(OLD.`description`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_address_components / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_address_components_ai`;
CREATE TRIGGER `trg_tbd_address_components_ai` AFTER INSERT ON `tbd_address_components`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_address_components', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_address_components: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('component_type=', IFNULL(NEW.`component_type`, 'NULL')), '; ', CONCAT('address_sup_ID=', IFNULL(NEW.`address_sup_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_address_components / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_address_components_au`;
CREATE TRIGGER `trg_tbd_address_components_au` AFTER UPDATE ON `tbd_address_components`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_address_components', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_address_components: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('address_ID (antes)=', IFNULL(OLD.`address_ID`, 'NULL'), '; address_ID (despues)=', IFNULL(NEW.`address_ID`, 'NULL')), '; ', CONCAT('component_type (antes)=', IFNULL(OLD.`component_type`, 'NULL'), '; component_type (despues)=', IFNULL(NEW.`component_type`, 'NULL')), '; ', CONCAT('address_sup_ID (antes)=', IFNULL(OLD.`address_sup_ID`, 'NULL'), '; address_sup_ID (despues)=', IFNULL(NEW.`address_sup_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_address_components / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_address_components_ad`;
CREATE TRIGGER `trg_tbd_address_components_ad` AFTER DELETE ON `tbd_address_components`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_address_components', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_address_components: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('address_ID=', IFNULL(OLD.`address_ID`, 'NULL')), '; ', CONCAT('component_type=', IFNULL(OLD.`component_type`, 'NULL')), '; ', CONCAT('address_sup_ID=', IFNULL(OLD.`address_sup_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_cancellation_items / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_cancellation_items_ai`;
CREATE TRIGGER `trg_tbd_cancellation_items_ai` AFTER INSERT ON `tbd_cancellation_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cancellation_items', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_cancellation_items: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_cancellation_items / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_cancellation_items_au`;
CREATE TRIGGER `trg_tbd_cancellation_items_au` AFTER UPDATE ON `tbd_cancellation_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cancellation_items', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_cancellation_items: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('cancellation_ID (antes)=', IFNULL(OLD.`cancellation_ID`, 'NULL'), '; cancellation_ID (despues)=', IFNULL(NEW.`cancellation_ID`, 'NULL')), '; ', CONCAT('order_item_ID (antes)=', IFNULL(OLD.`order_item_ID`, 'NULL'), '; order_item_ID (despues)=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_cancellation_items / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_cancellation_items_ad`;
CREATE TRIGGER `trg_tbd_cancellation_items_ad` AFTER DELETE ON `tbd_cancellation_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cancellation_items', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_cancellation_items: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('cancellation_ID=', IFNULL(OLD.`cancellation_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(OLD.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_cart_items / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_cart_items_ai`;
CREATE TRIGGER `trg_tbd_cart_items_ai` AFTER INSERT ON `tbd_cart_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cart_items', 'INSERT', USER(), CONCAT(NEW.cart_ID, '-', NEW.provider_ID, '-', NEW.product_ID),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_cart_items: ', CONCAT(CONCAT('cart_ID=', IFNULL(NEW.`cart_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_cart_items / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_cart_items_au`;
CREATE TRIGGER `trg_tbd_cart_items_au` AFTER UPDATE ON `tbd_cart_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cart_items', 'UPDATE', USER(), CONCAT(NEW.cart_ID, '-', NEW.provider_ID, '-', NEW.product_ID),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_cart_items: ', CONCAT(CONCAT('cart_ID (antes)=', IFNULL(OLD.`cart_ID`, 'NULL'), '; cart_ID (despues)=', IFNULL(NEW.`cart_ID`, 'NULL')), '; ', CONCAT('provider_ID (antes)=', IFNULL(OLD.`provider_ID`, 'NULL'), '; provider_ID (despues)=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_cart_items / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_cart_items_ad`;
CREATE TRIGGER `trg_tbd_cart_items_ad` AFTER DELETE ON `tbd_cart_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_cart_items', 'DELETE', USER(), CONCAT(OLD.cart_ID, '-', OLD.provider_ID, '-', OLD.product_ID),
    OLD.provider_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_cart_items: ', CONCAT(CONCAT('cart_ID=', IFNULL(OLD.`cart_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(OLD.`provider_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_order_items / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_order_items_ai`;
CREATE TRIGGER `trg_tbd_order_items_ai` AFTER INSERT ON `tbd_order_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_order_items', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_order_items: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('seller_order_ID=', IFNULL(NEW.`seller_order_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_name=', IFNULL(NEW.`product_name`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')), '; ', CONCAT('unit_price=', IFNULL(NEW.`unit_price`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_order_items / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_order_items_au`;
CREATE TRIGGER `trg_tbd_order_items_au` AFTER UPDATE ON `tbd_order_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_order_items', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.provider_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_order_items: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('seller_order_ID (antes)=', IFNULL(OLD.`seller_order_ID`, 'NULL'), '; seller_order_ID (despues)=', IFNULL(NEW.`seller_order_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('provider_ID (antes)=', IFNULL(OLD.`provider_ID`, 'NULL'), '; provider_ID (despues)=', IFNULL(NEW.`provider_ID`, 'NULL')), '; ', CONCAT('product_name (antes)=', IFNULL(OLD.`product_name`, 'NULL'), '; product_name (despues)=', IFNULL(NEW.`product_name`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')), '; ', CONCAT('unit_price (antes)=', IFNULL(OLD.`unit_price`, 'NULL'), '; unit_price (despues)=', IFNULL(NEW.`unit_price`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_order_items / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_order_items_ad`;
CREATE TRIGGER `trg_tbd_order_items_ad` AFTER DELETE ON `tbd_order_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_order_items', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.provider_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_order_items: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('seller_order_ID=', IFNULL(OLD.`seller_order_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('provider_ID=', IFNULL(OLD.`provider_ID`, 'NULL')), '; ', CONCAT('product_name=', IFNULL(OLD.`product_name`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')), '; ', CONCAT('unit_price=', IFNULL(OLD.`unit_price`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_products_categories / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_products_categories_ai`;
CREATE TRIGGER `trg_tbd_products_categories_ai` AFTER INSERT ON `tbd_products_categories`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_categories', 'INSERT', USER(), CONCAT(NEW.product_ID, '-', NEW.category_ID),
    NULL,
    NEW.product_ID,
    NEW.category_ID,
    CONCAT('INSERT en tbd_products_categories: ', CONCAT(CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('category_ID=', IFNULL(NEW.`category_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_products_categories / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_products_categories_au`;
CREATE TRIGGER `trg_tbd_products_categories_au` AFTER UPDATE ON `tbd_products_categories`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_categories', 'UPDATE', USER(), CONCAT(NEW.product_ID, '-', NEW.category_ID),
    NULL,
    NEW.product_ID,
    NEW.category_ID,
    CONCAT('UPDATE en tbd_products_categories: ', CONCAT(CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('category_ID (antes)=', IFNULL(OLD.`category_ID`, 'NULL'), '; category_ID (despues)=', IFNULL(NEW.`category_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_products_categories / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_products_categories_ad`;
CREATE TRIGGER `trg_tbd_products_categories_ad` AFTER DELETE ON `tbd_products_categories`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_categories', 'DELETE', USER(), CONCAT(OLD.product_ID, '-', OLD.category_ID),
    NULL,
    OLD.product_ID,
    OLD.category_ID,
    CONCAT('DELETE en tbd_products_categories: ', CONCAT(CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('category_ID=', IFNULL(OLD.`category_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_products_users_providers / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_products_users_providers_ai`;
CREATE TRIGGER `trg_tbd_products_users_providers_ai` AFTER INSERT ON `tbd_products_users_providers`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_users_providers', 'INSERT', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_products_users_providers: ', CONCAT(CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('type_ownership=', IFNULL(NEW.`type_ownership`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_products_users_providers / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_products_users_providers_au`;
CREATE TRIGGER `trg_tbd_products_users_providers_au` AFTER UPDATE ON `tbd_products_users_providers`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_users_providers', 'UPDATE', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_products_users_providers: ', CONCAT(CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('type_ownership (antes)=', IFNULL(OLD.`type_ownership`, 'NULL'), '; type_ownership (despues)=', IFNULL(NEW.`type_ownership`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_products_users_providers / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_products_users_providers_ad`;
CREATE TRIGGER `trg_tbd_products_users_providers_ad` AFTER DELETE ON `tbd_products_users_providers`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_products_users_providers', 'DELETE', USER(), CONCAT(OLD.user_ID, '-', OLD.product_ID),
    OLD.user_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_products_users_providers: ', CONCAT(CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('type_ownership=', IFNULL(OLD.`type_ownership`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_return_items / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_return_items_ai`;
CREATE TRIGGER `trg_tbd_return_items_ai` AFTER INSERT ON `tbd_return_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_return_items', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_return_items: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_return_items / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_return_items_au`;
CREATE TRIGGER `trg_tbd_return_items_au` AFTER UPDATE ON `tbd_return_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_return_items', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_return_items: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('return_ID (antes)=', IFNULL(OLD.`return_ID`, 'NULL'), '; return_ID (despues)=', IFNULL(NEW.`return_ID`, 'NULL')), '; ', CONCAT('order_item_ID (antes)=', IFNULL(OLD.`order_item_ID`, 'NULL'), '; order_item_ID (despues)=', IFNULL(NEW.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity (antes)=', IFNULL(OLD.`quantity`, 'NULL'), '; quantity (despues)=', IFNULL(NEW.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_return_items / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_return_items_ad`;
CREATE TRIGGER `trg_tbd_return_items_ad` AFTER DELETE ON `tbd_return_items`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_return_items', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    NULL,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_return_items: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('return_ID=', IFNULL(OLD.`return_ID`, 'NULL')), '; ', CONCAT('order_item_ID=', IFNULL(OLD.`order_item_ID`, 'NULL')), '; ', CONCAT('quantity=', IFNULL(OLD.`quantity`, 'NULL')))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_user_payment_methods / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_user_payment_methods_ai`;
CREATE TRIGGER `trg_tbd_user_payment_methods_ai` AFTER INSERT ON `tbd_user_payment_methods`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_user_payment_methods', 'INSERT', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('INSERT en tbd_user_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('provider=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('label=', IFNULL(NEW.`label`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_user_payment_methods / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_user_payment_methods_au`;
CREATE TRIGGER `trg_tbd_user_payment_methods_au` AFTER UPDATE ON `tbd_user_payment_methods`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_user_payment_methods', 'UPDATE', USER(), CAST(NEW.`ID` AS CHAR),
    NEW.user_ID,
    NULL,
    NULL,
    CONCAT('UPDATE en tbd_user_payment_methods: ', CONCAT(CONCAT('ID (antes)=', IFNULL(OLD.`ID`, 'NULL'), '; ID (despues)=', IFNULL(NEW.`ID`, 'NULL')), '; ', CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID (antes)=', IFNULL(OLD.`payment_method_type_ID`, 'NULL'), '; payment_method_type_ID (despues)=', IFNULL(NEW.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('provider (antes)=', IFNULL(OLD.`provider`, 'NULL'), '; provider (despues)=', IFNULL(NEW.`provider`, 'NULL')), '; ', CONCAT('label (antes)=', IFNULL(OLD.`label`, 'NULL'), '; label (despues)=', IFNULL(NEW.`label`, 'NULL')), '; ', CONCAT('is_default (antes)=', IFNULL(OLD.`is_default`, 'NULL'), '; is_default (despues)=', IFNULL(NEW.`is_default`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_user_payment_methods / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_user_payment_methods_ad`;
CREATE TRIGGER `trg_tbd_user_payment_methods_ad` AFTER DELETE ON `tbd_user_payment_methods`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_user_payment_methods', 'DELETE', USER(), CAST(OLD.`ID` AS CHAR),
    OLD.user_ID,
    NULL,
    NULL,
    CONCAT('DELETE en tbd_user_payment_methods: ', CONCAT(CONCAT('ID=', IFNULL(OLD.`ID`, 'NULL')), '; ', CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('payment_method_type_ID=', IFNULL(OLD.`payment_method_type_ID`, 'NULL')), '; ', CONCAT('provider=', IFNULL(OLD.`provider`, 'NULL')), '; ', CONCAT('label=', IFNULL(OLD.`label`, 'NULL')), '; ', CONCAT('is_default=', IFNULL(OLD.`is_default`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_users_wishlist_products / AFTER INSERT
DROP TRIGGER IF EXISTS `trg_tbd_users_wishlist_products_ai`;
CREATE TRIGGER `trg_tbd_users_wishlist_products_ai` AFTER INSERT ON `tbd_users_wishlist_products`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_users_wishlist_products', 'INSERT', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('INSERT en tbd_users_wishlist_products: ', CONCAT(CONCAT('user_ID=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('status=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_users_wishlist_products / AFTER UPDATE
DROP TRIGGER IF EXISTS `trg_tbd_users_wishlist_products_au`;
CREATE TRIGGER `trg_tbd_users_wishlist_products_au` AFTER UPDATE ON `tbd_users_wishlist_products`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_users_wishlist_products', 'UPDATE', USER(), CONCAT(NEW.user_ID, '-', NEW.product_ID),
    NEW.user_ID,
    NEW.product_ID,
    NULL,
    CONCAT('UPDATE en tbd_users_wishlist_products: ', CONCAT(CONCAT('user_ID (antes)=', IFNULL(OLD.`user_ID`, 'NULL'), '; user_ID (despues)=', IFNULL(NEW.`user_ID`, 'NULL')), '; ', CONCAT('product_ID (antes)=', IFNULL(OLD.`product_ID`, 'NULL'), '; product_ID (despues)=', IFNULL(NEW.`product_ID`, 'NULL')), '; ', CONCAT('status (antes)=', OLD.`status`+0, '; status (despues)=', NEW.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- tbd_users_wishlist_products / AFTER DELETE
DROP TRIGGER IF EXISTS `trg_tbd_users_wishlist_products_ad`;
CREATE TRIGGER `trg_tbd_users_wishlist_products_ad` AFTER DELETE ON `tbd_users_wishlist_products`
FOR EACH ROW
INSERT INTO `tb_logs` (
    `table_name`, `operation`, `db_user`, `record_id`,
    `user_id`, `product_id`, `category_id`,
    `description`, `operation_date`, `operation_status`
) VALUES (
    'tbd_users_wishlist_products', 'DELETE', USER(), CONCAT(OLD.user_ID, '-', OLD.product_ID),
    OLD.user_ID,
    OLD.product_ID,
    NULL,
    CONCAT('DELETE en tbd_users_wishlist_products: ', CONCAT(CONCAT('user_ID=', IFNULL(OLD.`user_ID`, 'NULL')), '; ', CONCAT('product_ID=', IFNULL(OLD.`product_ID`, 'NULL')), '; ', CONCAT('status=', OLD.`status`+0))),
    CURRENT_TIMESTAMP, b'1'
);

-- ------------------------------------------------------------
-- Verificacion: deben existir exactamente 72 triggers.
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_triggers FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'db_test';

SELECT EVENT_OBJECT_TABLE AS tabla, COUNT(*) AS triggers
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'db_test'
GROUP BY EVENT_OBJECT_TABLE ORDER BY EVENT_OBJECT_TABLE;
