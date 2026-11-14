-- ============================================================
-- PRACTICA 03 - Actividad 7
-- Poblacion de productos - Vendedor remoto seller1
-- Ejecutar con la cuenta MySQL seller1 (rol seller activo).
-- ============================================================
USE db_test;

CALL sp_poblar_productos(
    5000,                         -- 5,000 productos
    'seller1@ecommerce.test',     -- usuario vendedor
    'SELLER1',                    -- prefijo SKU
    10,                           -- 10% descontinuados
    10,                           -- precio minimo
    5000                          -- precio maximo
);

SELECT
    'Productos de seller1' AS verificacion,
    COUNT(*) AS total,
    SUM(CASE WHEN p.status = b'0' THEN 1 ELSE 0 END) AS descontinuados,
    COUNT(DISTINCT pc.category_ID) AS categorias_cubiertas,
    MIN(p.current_price) AS precio_min,
    MAX(p.current_price) AS precio_max
FROM tb_products p
JOIN tbd_products_users_providers pp ON pp.product_ID = p.ID
JOIN tb_users u ON u.ID = pp.user_ID
JOIN tbd_products_categories pc ON pc.product_ID = p.ID
WHERE u.email = 'seller1@ecommerce.test';

SELECT 'seller1' AS vendedor, db_user, COUNT(*) AS eventos
FROM tb_logs
WHERE table_name = 'tb_products'
  AND db_user LIKE 'seller1%'
GROUP BY db_user;
