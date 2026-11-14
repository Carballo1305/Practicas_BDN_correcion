-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 8: Consultas SQL de verificacion y validacion
-- ============================================================
USE db_test;

-- ------------------------------------------------------------
-- 8.1 Cantidad total de tablas, triggers, vistas, rutinas y eventos
-- ------------------------------------------------------------
SELECT 'Tablas base' AS objeto, COUNT(*) AS total
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'db_test' AND TABLE_TYPE = 'BASE TABLE'
UNION ALL
SELECT 'Tablas operativas (sin tb_logs)', COUNT(*)
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'db_test' AND TABLE_TYPE = 'BASE TABLE'
  AND TABLE_NAME <> 'tb_logs'
UNION ALL
SELECT 'Triggers', COUNT(*)
FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA = 'db_test'
UNION ALL
SELECT 'Vistas', COUNT(*)
FROM information_schema.VIEWS WHERE TABLE_SCHEMA = 'db_test'
UNION ALL
SELECT 'Funciones', COUNT(*)
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'db_test' AND ROUTINE_TYPE = 'FUNCTION'
UNION ALL
SELECT 'Procedimientos', COUNT(*)
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'db_test' AND ROUTINE_TYPE = 'PROCEDURE'
UNION ALL
SELECT 'Eventos', COUNT(*)
FROM information_schema.EVENTS WHERE EVENT_SCHEMA = 'db_test';

-- ------------------------------------------------------------
-- 8.2 Distribucion de los 7,500 usuarios simulados
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN email LIKE 't1\_%' THEN 'Test 1: 500 hombres de US'
        WHEN email LIKE 't2\_%' THEN 'Test 2: 2000 paises, 19-35'
        WHEN email LIKE 't3\_%' THEN 'Test 3: 5000, 80/20'
    END AS escenario,
    COUNT(*) AS total,
    SUM(status + 0) AS activos,
    SUM(1 - (status + 0)) AS inactivos
FROM tb_users
WHERE email LIKE 't1\_%' OR email LIKE 't2\_%' OR email LIKE 't3\_%'
GROUP BY escenario
ORDER BY escenario;

SELECT 'Total usuarios simulados' AS verificacion, COUNT(*) AS total
FROM tb_users
WHERE email LIKE 't1\_%' OR email LIKE 't2\_%' OR email LIKE 't3\_%';

SELECT 'Test 1: hombres de US' AS verificacion, COUNT(*) AS total
FROM tb_users u
JOIN tb_people p ON p.user_ID = u.ID
WHERE u.email LIKE 't1\_%' AND p.gender = 'Hombre' AND p.country_code = 'US';

SELECT
    'Test 2: rango de edad' AS verificacion,
    MIN(TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE())) AS edad_min,
    MAX(TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE())) AS edad_max,
    COUNT(DISTINCT p.country_code) AS paises
FROM tb_users u
JOIN tb_people p ON p.user_ID = u.ID
WHERE u.email LIKE 't2\_%';

SELECT
    'Test 3: proporcion activos' AS verificacion,
    COUNT(*) AS total,
    SUM(status + 0) AS activos,
    ROUND(100 * SUM(status + 0) / COUNT(*), 2) AS pct_activos
FROM tb_users
WHERE email LIKE 't3\_%';

-- ------------------------------------------------------------
-- 8.3 Integridad tb_users <-> tb_people
-- ------------------------------------------------------------
SELECT
    'Usuarios simulados con persona' AS verificacion,
    COUNT(*) AS usuarios,
    SUM(CASE WHEN p.user_ID IS NULL THEN 1 ELSE 0 END) AS sin_persona,
    SUM(CASE WHEN p.status <> u.status THEN 1 ELSE 0 END) AS estados_inconsistentes
FROM tb_users u
LEFT JOIN tb_people p ON p.user_ID = u.ID
WHERE u.email LIKE 't1\_%' OR u.email LIKE 't2\_%' OR u.email LIKE 't3\_%';

-- ------------------------------------------------------------
-- 8.4 Productos y distribucion entre vendedores
-- ------------------------------------------------------------
SELECT
    'Total de productos' AS verificacion,
    COUNT(*) AS total,
    SUM(CASE WHEN status = b'1' THEN 1 ELSE 0 END) AS activos,
    SUM(CASE WHEN status = b'0' THEN 1 ELSE 0 END) AS descontinuados
FROM tb_products;

SELECT
    u.nick AS vendedor,
    u.email,
    COUNT(DISTINCT pp.product_ID) AS productos,
    SUM(CASE WHEN p.status = b'0' THEN 1 ELSE 0 END) AS descontinuados
FROM tbd_products_users_providers pp
JOIN tb_users u ON u.ID = pp.user_ID
JOIN tb_products p ON p.ID = pp.product_ID
WHERE u.email IN ('seller1@ecommerce.test', 'seller2@ecommerce.test')
GROUP BY u.nick, u.email
ORDER BY u.nick;

SELECT
    'Productos con vendedor asignado' AS verificacion,
    COUNT(DISTINCT pp.product_ID) AS total
FROM tbd_products_users_providers pp
JOIN tb_users u ON u.ID = pp.user_ID
WHERE u.email IN ('seller1@ecommerce.test', 'seller2@ecommerce.test');

-- ------------------------------------------------------------
-- 8.5 Categorias con menos de 5 productos (debe devolver 0 filas)
-- ------------------------------------------------------------
SELECT
    c.id,
    c.name,
    COUNT(DISTINCT pc.product_ID) AS productos
FROM tbc_categories c
LEFT JOIN tbd_products_categories pc ON pc.category_ID = c.id
GROUP BY c.id, c.name
HAVING COUNT(DISTINCT pc.product_ID) < 5
ORDER BY productos, c.id;

-- ------------------------------------------------------------
-- 8.6 Distribucion de productos por categoria (vista 25)
-- ------------------------------------------------------------
SELECT
    category_id,
    category_name,
    category_level,
    total_products,
    active_products,
    discontinued_products,
    total_stock
FROM vw_productos_por_categoria
ORDER BY total_products DESC, category_id
LIMIT 15;

SELECT
    'Categorias/subcategorias sin productos' AS verificacion,
    COUNT(*) AS total
FROM vw_productos_por_categoria
WHERE total_products = 0;

-- ------------------------------------------------------------
-- 8.7 Trazabilidad por cuenta remota y tipo de operacion
-- ------------------------------------------------------------
SELECT
    db_user,
    table_name,
    operation,
    COUNT(*) AS eventos
FROM tb_logs
WHERE db_user LIKE 'remoto_superadmin%'
   OR db_user LIKE 'seller1%'
   OR db_user LIKE 'seller2%'
GROUP BY db_user, table_name, operation
ORDER BY db_user, table_name, operation;

SELECT
    'Inserciones de usuarios por superadmin remoto' AS verificacion,
    COUNT(*) AS eventos
FROM tb_logs
WHERE table_name = 'tb_users'
  AND operation = 'INSERT'
  AND db_user LIKE 'remoto_superadmin%';

SELECT
    'Inserciones de productos por seller1/seller2' AS verificacion,
    SUM(CASE WHEN db_user LIKE 'seller1%' THEN 1 ELSE 0 END) AS seller1,
    SUM(CASE WHEN db_user LIKE 'seller2%' THEN 1 ELSE 0 END) AS seller2
FROM tb_logs
WHERE table_name = 'tb_products' AND operation = 'INSERT';

-- Muestra de la vista de trazabilidad de usuarios
SELECT ID, username, email, log_db_user, log_description, log_date
FROM vw_trazabilidad_usuarios
WHERE email LIKE 't1\_%'
ORDER BY ID
LIMIT 5;

-- Muestra de la vista de trazabilidad de productos de seller1
SELECT id, SKU, name, log_db_user, log_operation, log_date
FROM vw_trazabilidad_productos
WHERE log_db_user LIKE 'seller1%'
ORDER BY log_id DESC
LIMIT 5;

-- ------------------------------------------------------------
-- 8.8 Integridad referencial y registros huerfanos
-- ------------------------------------------------------------
SELECT 'Personas sin usuario' AS verificacion, COUNT(*) AS total
FROM tb_people p LEFT JOIN tb_users u ON u.ID = p.user_ID
WHERE u.ID IS NULL;

SELECT 'Productos-categoria sin producto' AS verificacion, COUNT(*) AS total
FROM tbd_products_categories pc LEFT JOIN tb_products p ON p.ID = pc.product_ID
WHERE p.ID IS NULL;

SELECT 'Productos-categoria sin categoria' AS verificacion, COUNT(*) AS total
FROM tbd_products_categories pc LEFT JOIN tbc_categories c ON c.id = pc.category_ID
WHERE c.id IS NULL;

SELECT 'Proveedor-producto sin producto' AS verificacion, COUNT(*) AS total
FROM tbd_products_users_providers pp LEFT JOIN tb_products p ON p.ID = pp.product_ID
WHERE p.ID IS NULL;

SELECT 'Proveedor-producto sin usuario' AS verificacion, COUNT(*) AS total
FROM tbd_products_users_providers pp LEFT JOIN tb_users u ON u.ID = pp.user_ID
WHERE u.ID IS NULL;

SELECT 'Items de orden sin orden' AS verificacion, COUNT(*) AS total
FROM tbd_order_items oi LEFT JOIN tb_orders o ON o.ID = oi.seller_order_ID
WHERE o.ID IS NULL;

-- ------------------------------------------------------------
-- 8.9 Duplicados e incorformidades
-- ------------------------------------------------------------
SELECT 'Emails duplicados' AS verificacion, COUNT(*) AS total
FROM (SELECT email FROM tb_users GROUP BY email HAVING COUNT(*) > 1) x;

SELECT 'Nicks duplicados' AS verificacion, COUNT(*) AS total
FROM (SELECT nick FROM tb_users GROUP BY nick HAVING COUNT(*) > 1) x;

SELECT 'SKU duplicados' AS verificacion, COUNT(*) AS total
FROM (SELECT SKU FROM tb_products GROUP BY SKU HAVING COUNT(*) > 1) x;

SELECT 'Precios o stock invalidos' AS verificacion, COUNT(*) AS total
FROM tb_products
WHERE current_price < 0 OR current_stock < 0;

-- ------------------------------------------------------------
-- 8.10 Roles, privilegios y roles activos por defecto
-- ------------------------------------------------------------
SELECT FROM_USER AS rol, TO_USER AS usuario_asignado
FROM mysql.role_edges
WHERE TO_USER IN ('remoto_superadmin','remoto_admin','remoto_support',
                  'seller1','seller2','buyer1','common1','guest1')
ORDER BY TO_USER;

SELECT USER AS usuario, DEFAULT_ROLE_USER AS rol_predeterminado
FROM mysql.default_roles
WHERE USER IN ('remoto_superadmin','remoto_admin','remoto_support',
               'seller1','seller2','buyer1','common1','guest1')
ORDER BY USER;

-- ------------------------------------------------------------
-- 8.11 Estado de los eventos programados
-- ------------------------------------------------------------
SELECT EVENT_NAME, STATUS, INTERVAL_VALUE, INTERVAL_FIELD,
       STARTS, LAST_EXECUTED
FROM information_schema.EVENTS
WHERE EVENT_SCHEMA = 'db_test'
ORDER BY EVENT_NAME;
