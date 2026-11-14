-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 1: Integracion y actualizacion del esquema relacional
-- Correcciones necesarias detectadas antes de implementar
-- triggers, vistas, rutinas y simulaciones.
-- ============================================================
USE db_test;

-- ------------------------------------------------------------
-- 1. Corregir la FK huerfana de tbd_order_items.
--    Referenciaba tb_buyer_orders, tabla que no existe en el
--    modelo de 25 tablas. Los items de una orden deben apuntar
--    a la orden del comprador (tb_orders.ID).
-- ------------------------------------------------------------
ALTER TABLE tbd_order_items
    DROP FOREIGN KEY tbd_order_items_ibfk_1;

ALTER TABLE tbd_order_items
    ADD CONSTRAINT fk_order_items_order
        FOREIGN KEY (seller_order_ID) REFERENCES tb_orders (ID)
        ON DELETE CASCADE ON UPDATE CASCADE;

-- ------------------------------------------------------------
-- 2. Agregar record_id a tb_logs para poder relacionar cada
--    registro operativo con sus eventos de auditoria.
--    Formato:
--      - Tablas con PK simple: valor de la PK.
--      - Tablas con PK compuesta: valores separados por '-'.
-- ------------------------------------------------------------
ALTER TABLE tb_logs
    ADD COLUMN record_id VARCHAR(150) NULL AFTER user_id,
    ADD INDEX idx_logs_table_record (table_name, record_id);

-- ------------------------------------------------------------
-- 3. Verificacion de integridad referencial del modelo.
-- ------------------------------------------------------------
SELECT
    'FKs huerfanas' AS verificacion,
    COUNT(*) AS total
FROM information_schema.KEY_COLUMN_USAGE k
LEFT JOIN information_schema.TABLES t
       ON t.TABLE_SCHEMA = k.REFERENCED_TABLE_SCHEMA
      AND t.TABLE_NAME   = k.REFERENCED_TABLE_NAME
WHERE k.TABLE_SCHEMA = 'db_test'
  AND k.REFERENCED_TABLE_NAME IS NOT NULL
  AND t.TABLE_NAME IS NULL;

SELECT
    'Tablas base operativas (sin tb_logs)' AS verificacion,
    COUNT(*) AS total
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'db_test'
  AND TABLE_TYPE = 'BASE TABLE'
  AND TABLE_NAME <> 'tb_logs';

SELECT
    'Tablas base totales (incluye tb_logs)' AS verificacion,
    COUNT(*) AS total
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'db_test'
  AND TABLE_TYPE = 'BASE TABLE';
