-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 4: Usuarios, roles y privilegios de acceso remoto
-- ============================================================
USE db_test;

-- ------------------------------------------------------------
-- 1. LOS SIETE ROLES DEL SISTEMA
-- ------------------------------------------------------------
CREATE ROLE IF NOT EXISTS 'superadmin'@'%';
CREATE ROLE IF NOT EXISTS 'admin'@'%';
CREATE ROLE IF NOT EXISTS 'support'@'%';
CREATE ROLE IF NOT EXISTS 'seller'@'%';
CREATE ROLE IF NOT EXISTS 'buyer'@'%';
CREATE ROLE IF NOT EXISTS 'common_user'@'%';
CREATE ROLE IF NOT EXISTS 'user_not_registered'@'%';

-- Rol legado sin asignaciones, se elimina para dejar exactamente 7 roles.
DROP ROLE IF EXISTS 'common'@'%';

-- ------------------------------------------------------------
-- 2. PRIVILEGIOS POR ROL
-- ------------------------------------------------------------
-- Limpieza de privilegios amplios heredados de practicas anteriores.
-- ADMIN no debe tener DDL y SUPPORT no debe administrar usuarios ni roles.
REVOKE IF EXISTS ALL PRIVILEGES ON db_test.* FROM 'admin'@'%';
REVOKE IF EXISTS SELECT, INSERT, UPDATE, EXECUTE, SHOW VIEW ON db_test.* FROM 'support'@'%';
REVOKE IF EXISTS SHOW DATABASES, CREATE USER ON *.* FROM 'support'@'%';
REVOKE IF EXISTS ROLE_ADMIN ON *.* FROM 'support'@'%';

-- SUPERADMIN: control total sobre la base de datos.
GRANT ALL PRIVILEGES ON db_test.* TO 'superadmin'@'%';

-- ADMIN: CRUD sobre las 24 tablas operativas, lectura de bitacora
-- y ejecucion de rutinas. Sin privilegios DDL.
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_carts TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_order_cancellations TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_orders TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_payment_methods TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_payment_transaction TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_payments TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_people TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_products TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_refunds TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_returns TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_shipments TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_user_addresses TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_users TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbc_categories TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbc_payment_methods_types TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_address_components TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_cancellation_items TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_cart_items TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_order_items TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_products_categories TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_products_users_providers TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_return_items TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_user_payment_methods TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_users_wishlist_products TO 'admin'@'%';
GRANT SELECT ON db_test.tb_logs TO 'admin'@'%';
GRANT EXECUTE ON db_test.* TO 'admin'@'%';

-- SUPPORT: consulta general, actualizacion de pedidos, envios,
-- devoluciones y cancelaciones; lectura de bitacora.
GRANT SELECT ON db_test.tb_carts TO 'support'@'%';
GRANT SELECT, UPDATE ON db_test.tb_order_cancellations TO 'support'@'%';
GRANT SELECT, UPDATE ON db_test.tb_orders TO 'support'@'%';
GRANT SELECT ON db_test.tb_payment_methods TO 'support'@'%';
GRANT SELECT ON db_test.tb_payment_transaction TO 'support'@'%';
GRANT SELECT ON db_test.tb_payments TO 'support'@'%';
GRANT SELECT ON db_test.tb_people TO 'support'@'%';
GRANT SELECT ON db_test.tb_products TO 'support'@'%';
GRANT SELECT ON db_test.tb_refunds TO 'support'@'%';
GRANT SELECT, UPDATE ON db_test.tb_returns TO 'support'@'%';
GRANT SELECT, UPDATE ON db_test.tb_shipments TO 'support'@'%';
GRANT SELECT ON db_test.tb_user_addresses TO 'support'@'%';
GRANT SELECT, UPDATE ON db_test.tb_users TO 'support'@'%';
GRANT SELECT ON db_test.tbc_categories TO 'support'@'%';
GRANT SELECT ON db_test.tbc_payment_methods_types TO 'support'@'%';
GRANT SELECT ON db_test.tbd_address_components TO 'support'@'%';
GRANT SELECT ON db_test.tbd_cancellation_items TO 'support'@'%';
GRANT SELECT ON db_test.tbd_cart_items TO 'support'@'%';
GRANT SELECT ON db_test.tbd_order_items TO 'support'@'%';
GRANT SELECT ON db_test.tbd_products_categories TO 'support'@'%';
GRANT SELECT ON db_test.tbd_products_users_providers TO 'support'@'%';
GRANT SELECT ON db_test.tbd_return_items TO 'support'@'%';
GRANT SELECT ON db_test.tbd_user_payment_methods TO 'support'@'%';
GRANT SELECT ON db_test.tbd_users_wishlist_products TO 'support'@'%';
GRANT SELECT ON db_test.tb_logs TO 'support'@'%';
GRANT EXECUTE ON db_test.* TO 'support'@'%';

-- SELLER: gestion de productos, categorias de producto y
-- proveedores. Sin DELETE fisico de productos (baja logica).
GRANT SELECT, INSERT, UPDATE ON db_test.tb_products TO 'seller'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_products_categories TO 'seller'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_products_users_providers TO 'seller'@'%';
GRANT SELECT ON db_test.tbc_categories TO 'seller'@'%';
GRANT SELECT ON db_test.tbc_payment_methods_types TO 'seller'@'%';
GRANT SELECT ON db_test.tb_users TO 'seller'@'%';
GRANT SELECT ON db_test.tb_people TO 'seller'@'%';
GRANT SELECT ON db_test.tb_logs TO 'seller'@'%';
GRANT EXECUTE ON PROCEDURE db_test.sp_poblar_productos TO 'seller'@'%';
GRANT EXECUTE ON PROCEDURE db_test.sp_soft_delete_product TO 'seller'@'%';
GRANT EXECUTE ON PROCEDURE db_test.sp_restore_product TO 'seller'@'%';

-- BUYER: consulta de catalogo y gestion de su carrito y pedidos.
GRANT SELECT ON db_test.tb_products TO 'buyer'@'%';
GRANT SELECT ON db_test.tbc_categories TO 'buyer'@'%';
GRANT SELECT ON db_test.tbc_payment_methods_types TO 'buyer'@'%';
GRANT SELECT ON db_test.tbd_products_categories TO 'buyer'@'%';
GRANT SELECT ON db_test.tbd_products_users_providers TO 'buyer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_carts TO 'buyer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_cart_items TO 'buyer'@'%';
GRANT SELECT, INSERT ON db_test.tb_orders TO 'buyer'@'%';
GRANT SELECT, INSERT ON db_test.tbd_order_items TO 'buyer'@'%';
GRANT SELECT ON db_test.tb_order_cancellations TO 'buyer'@'%';
GRANT SELECT ON db_test.tb_returns TO 'buyer'@'%';
GRANT SELECT ON db_test.tb_payments TO 'buyer'@'%';
GRANT SELECT ON db_test.tb_shipments TO 'buyer'@'%';

-- COMMON_USER: catalogo, perfil propio y carrito.
GRANT SELECT ON db_test.tb_products TO 'common_user'@'%';
GRANT SELECT ON db_test.tbc_categories TO 'common_user'@'%';
GRANT SELECT ON db_test.tbd_products_categories TO 'common_user'@'%';
GRANT SELECT ON db_test.tbd_products_users_providers TO 'common_user'@'%';
GRANT SELECT, INSERT, UPDATE ON db_test.tb_users TO 'common_user'@'%';
GRANT SELECT, INSERT, UPDATE ON db_test.tb_people TO 'common_user'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_user_addresses TO 'common_user'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tb_carts TO 'common_user'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test.tbd_cart_items TO 'common_user'@'%';
GRANT SELECT ON db_test.tb_orders TO 'common_user'@'%';
GRANT SELECT ON db_test.tbd_order_items TO 'common_user'@'%';

-- USER_NOT_REGISTERED: solo catalogo publico.
GRANT SELECT ON db_test.tb_products TO 'user_not_registered'@'%';
GRANT SELECT ON db_test.tbc_categories TO 'user_not_registered'@'%';
GRANT SELECT ON db_test.tbd_products_categories TO 'user_not_registered'@'%';
GRANT SELECT ON db_test.tbd_products_users_providers TO 'user_not_registered'@'%';

-- ------------------------------------------------------------
-- 3. PERMISOS DE LECTURA SOBRE LAS 25 VISTAS
--    Las vistas de trazabilidad son de uso administrativo.
--    seller solo accede a las vistas de su dominio (productos).
--    buyer/common_user/user_not_registered solo al catalogo.
-- ------------------------------------------------------------
-- Limpieza de permisos amplios de versiones anteriores
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_address_components FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_cancellation_items FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_cart_items FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_carts FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_categorias FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_order_cancellations FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_order_items FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_orders FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_payment_methods FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_payment_methods_types FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_payment_transaction FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_payments FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_people FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_productos FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_productos_categorias FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_products_users_providers FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_refunds FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_return_items FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_returns FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_shipments FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_user_addresses FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_user_payment_methods FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_users_wishlist_products FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';
REVOKE IF EXISTS SELECT ON db_test.vw_trazabilidad_usuarios FROM 'seller'@'%', 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';

-- Administracion y soporte: las 25 vistas
GRANT SELECT ON db_test.vw_productos_por_categoria TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_address_components TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_cancellation_items TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_cart_items TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_carts TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_categorias TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_order_cancellations TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_order_items TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_orders TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_payment_methods TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_payment_methods_types TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_payment_transaction TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_payments TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_people TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_productos TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_productos_categorias TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_products_users_providers TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_refunds TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_return_items TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_returns TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_shipments TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_user_addresses TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_user_payment_methods TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_users_wishlist_products TO 'admin'@'%', 'support'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_usuarios TO 'admin'@'%', 'support'@'%';

-- Seller: vistas de su dominio
GRANT SELECT ON db_test.vw_productos_por_categoria TO 'seller'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_categorias TO 'seller'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_productos TO 'seller'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_productos_categorias TO 'seller'@'%';
GRANT SELECT ON db_test.vw_trazabilidad_products_users_providers TO 'seller'@'%';

-- Compradores e invitados: solo la vista de catalogo
GRANT SELECT ON db_test.vw_productos_por_categoria TO 'buyer'@'%', 'common_user'@'%', 'user_not_registered'@'%';

-- ------------------------------------------------------------
-- 4. CUENTAS REMOTAS Y ASIGNACION DE ROLES
-- ------------------------------------------------------------
CREATE USER IF NOT EXISTS 'remoto_superadmin'@'%' IDENTIFIED BY 'Sup3r#2026';
ALTER USER 'remoto_superadmin'@'%' IDENTIFIED BY 'Sup3r#2026';
GRANT 'superadmin'@'%' TO 'remoto_superadmin'@'%';
SET DEFAULT ROLE ALL TO 'remoto_superadmin'@'%';

CREATE USER IF NOT EXISTS 'remoto_admin'@'%' IDENTIFIED BY 'Adm1n#2026';
ALTER USER 'remoto_admin'@'%' IDENTIFIED BY 'Adm1n#2026';
GRANT 'admin'@'%' TO 'remoto_admin'@'%';
SET DEFAULT ROLE ALL TO 'remoto_admin'@'%';

CREATE USER IF NOT EXISTS 'remoto_support'@'%' IDENTIFIED BY 'Supp0rt#2026';
ALTER USER 'remoto_support'@'%' IDENTIFIED BY 'Supp0rt#2026';
GRANT 'support'@'%' TO 'remoto_support'@'%';
SET DEFAULT ROLE ALL TO 'remoto_support'@'%';

CREATE USER IF NOT EXISTS 'seller1'@'%' IDENTIFIED BY 'Sell3r1#2026';
ALTER USER 'seller1'@'%' IDENTIFIED BY 'Sell3r1#2026';
GRANT 'seller'@'%' TO 'seller1'@'%';
SET DEFAULT ROLE ALL TO 'seller1'@'%';

CREATE USER IF NOT EXISTS 'seller2'@'%' IDENTIFIED BY 'Sell3r2#2026';
ALTER USER 'seller2'@'%' IDENTIFIED BY 'Sell3r2#2026';
GRANT 'seller'@'%' TO 'seller2'@'%';
SET DEFAULT ROLE ALL TO 'seller2'@'%';

CREATE USER IF NOT EXISTS 'buyer1'@'%' IDENTIFIED BY 'Buy3r1#2026';
ALTER USER 'buyer1'@'%' IDENTIFIED BY 'Buy3r1#2026';
GRANT 'buyer'@'%' TO 'buyer1'@'%';
SET DEFAULT ROLE ALL TO 'buyer1'@'%';

CREATE USER IF NOT EXISTS 'common1'@'%' IDENTIFIED BY 'C0mm0n#2026';
ALTER USER 'common1'@'%' IDENTIFIED BY 'C0mm0n#2026';
GRANT 'common_user'@'%' TO 'common1'@'%';
SET DEFAULT ROLE ALL TO 'common1'@'%';

CREATE USER IF NOT EXISTS 'guest1'@'%' IDENTIFIED BY 'Gu3st1#2026';
ALTER USER 'guest1'@'%' IDENTIFIED BY 'Gu3st1#2026';
GRANT 'user_not_registered'@'%' TO 'guest1'@'%';
SET DEFAULT ROLE ALL TO 'guest1'@'%';

-- ------------------------------------------------------------
-- 5. USUARIOS DE APLICACION PARA LOS VENDEDORES REMOTOS
-- ------------------------------------------------------------
INSERT INTO tb_users (email, nick, roles, password, status)
SELECT 'seller1@ecommerce.test', 'seller1', 'seller',
       SHA2('Seller1#2026', 256), b'1'
WHERE NOT EXISTS (
    SELECT 1 FROM tb_users WHERE email = 'seller1@ecommerce.test'
);

INSERT INTO tb_users (email, nick, roles, password, status)
SELECT 'seller2@ecommerce.test', 'seller2', 'seller',
       SHA2('Seller2#2026', 256), b'1'
WHERE NOT EXISTS (
    SELECT 1 FROM tb_users WHERE email = 'seller2@ecommerce.test'
);

INSERT INTO tb_people (user_ID, given_names, family_names, birth_date,
                       gender, country_code, phone, status)
SELECT u.ID, 'Vendedor', 'Remoto Uno', '1990-01-15', 'Hombre', 'MX', '+520000000001', b'1'
FROM tb_users u
WHERE u.email = 'seller1@ecommerce.test'
  AND NOT EXISTS (SELECT 1 FROM tb_people p WHERE p.user_ID = u.ID);

INSERT INTO tb_people (user_ID, given_names, family_names, birth_date,
                       gender, country_code, phone, status)
SELECT u.ID, 'Vendedor', 'Remoto Dos', '1992-06-20', 'Mujer', 'MX', '+520000000002', b'1'
FROM tb_users u
WHERE u.email = 'seller2@ecommerce.test'
  AND NOT EXISTS (SELECT 1 FROM tb_people p WHERE p.user_ID = u.ID);

-- ------------------------------------------------------------
-- 6. VERIFICACION
-- ------------------------------------------------------------
SELECT user, host, account_locked
FROM mysql.user
WHERE user IN ('superadmin','admin','support','seller','buyer','common_user','user_not_registered',
               'remoto_superadmin','remoto_admin','remoto_support','seller1','seller2','buyer1','common1','guest1')
ORDER BY user;

SELECT FROM_USER AS rol, TO_USER AS usuario
FROM mysql.role_edges
WHERE TO_USER IN ('remoto_superadmin','remoto_admin','remoto_support','seller1','seller2','buyer1','common1','guest1')
ORDER BY TO_USER;

SELECT HOST, USER, DEFAULT_ROLE_USER
FROM mysql.default_roles
WHERE USER IN ('remoto_superadmin','remoto_admin','remoto_support','seller1','seller2','buyer1','common1','guest1')
ORDER BY USER;
