-- ============================================================
-- Validacion final consolidada - Practica 03
-- ============================================================
USE db_test;

SELECT 'Tablas base' AS indicador, COUNT(*) AS valor
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'db_test' AND TABLE_TYPE = 'BASE TABLE'
UNION ALL
SELECT 'Triggers', COUNT(*) FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA = 'db_test'
UNION ALL
SELECT 'Vistas', COUNT(*) FROM information_schema.VIEWS WHERE TABLE_SCHEMA = 'db_test'
UNION ALL
SELECT 'Funciones', COUNT(*) FROM information_schema.ROUTINES
 WHERE ROUTINE_SCHEMA = 'db_test' AND ROUTINE_TYPE = 'FUNCTION'
UNION ALL
SELECT 'Procedimientos', COUNT(*) FROM information_schema.ROUTINES
 WHERE ROUTINE_SCHEMA = 'db_test' AND ROUTINE_TYPE = 'PROCEDURE'
UNION ALL
SELECT 'Eventos', COUNT(*) FROM information_schema.EVENTS WHERE EVENT_SCHEMA = 'db_test'
UNION ALL
SELECT 'Roles', COUNT(*) FROM mysql.user
 WHERE account_locked = 'Y' AND user NOT LIKE 'mysql.%'
UNION ALL
SELECT 'Cuentas remotas', COUNT(*) FROM mysql.user
 WHERE user IN ('remoto_superadmin','remoto_admin','remoto_support',
                'seller1','seller2','buyer1','common1','guest1')
UNION ALL
SELECT 'Usuarios simulados', COUNT(*) FROM tb_users
 WHERE email LIKE 't1\_%' OR email LIKE 't2\_%' OR email LIKE 't3\_%'
UNION ALL
SELECT 'Productos totales', COUNT(*) FROM tb_products
UNION ALL
SELECT 'Productos con vendedor', COUNT(*) FROM tbd_products_users_providers
UNION ALL
SELECT 'Registros de bitacora', COUNT(*) FROM tb_logs;

-- Tablas operativas con exactamente 3 triggers
SELECT COUNT(*) AS tablas_con_3_triggers
FROM (
    SELECT EVENT_OBJECT_TABLE
    FROM information_schema.TRIGGERS
    WHERE TRIGGER_SCHEMA = 'db_test'
    GROUP BY EVENT_OBJECT_TABLE
    HAVING COUNT(*) = 3
) x;

-- Cobertura de privilegios sobre vistas
SELECT GRANTEE, COUNT(*) AS vistas_con_select
FROM information_schema.TABLE_PRIVILEGES
WHERE TABLE_SCHEMA = 'db_test' AND TABLE_NAME LIKE 'vw\_%'
GROUP BY GRANTEE
ORDER BY vistas_con_select DESC, GRANTEE;

-- Estado de los eventos
SELECT EVENT_NAME, STATUS, INTERVAL_VALUE, INTERVAL_FIELD
FROM information_schema.EVENTS
WHERE EVENT_SCHEMA = 'db_test'
ORDER BY EVENT_NAME;

-- Verificacion de que no quedan tablas temporales de pruebas
SELECT COUNT(*) AS tablas_zz_pendientes
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'db_test' AND TABLE_NAME LIKE 'zz\_%';
