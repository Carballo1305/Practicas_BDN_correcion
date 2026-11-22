-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 6: Simulacion y poblacion masiva de usuarios
-- Se ejecuta con la cuenta remota remoto_superadmin, que tiene
-- el rol superadmin asignado y activado por defecto.
-- ============================================================
USE db_test;

-- Limpieza de ejecuciones previas (permite repetir la simulacion)
DELETE p FROM tb_people p
JOIN tb_users u ON u.ID = p.user_ID
WHERE u.email LIKE 'test\_%'
   OR u.email LIKE 't1\_%'
   OR u.email LIKE 't2\_%'
   OR u.email LIKE 't3\_%';

DELETE FROM tb_users
WHERE email LIKE 'test\_%'
   OR email LIKE 't1\_%'
   OR email LIKE 't2\_%'
   OR email LIKE 't3\_%';

-- ------------------------------------------------------------
-- TEST 1: 500 usuarios de genero masculino, originarios de EE.UU.
-- ------------------------------------------------------------
CALL sp_simular_usuarios(
    500,          -- cantidad
    'Hombre',     -- genero
    'US',         -- pais
    18,           -- edad minima
    65,           -- edad maxima
    100,          -- 100% cuentas activas
    't1',         -- prefijo de identificacion
    'common_user' -- rol de aplicacion
);

-- ------------------------------------------------------------
-- TEST 2: 2,000 usuarios de diferentes paises, 19 a 35 anos.
-- ------------------------------------------------------------
CALL sp_simular_usuarios(
    2000,
    '*',          -- genero aleatorio
    '*',          -- pais aleatorio
    19,
    35,
    100,
    't2',
    'common_user'
);

-- ------------------------------------------------------------
-- TEST 3: 5,000 usuarios con 80% activos y 20% inactivos.
-- ------------------------------------------------------------
CALL sp_simular_usuarios(
    5000,
    '*',          -- genero aleatorio
    '*',          -- pais aleatorio
    18,
    65,
    80,           -- probabilidad de cuenta activa
    't3',
    'common_user'
);

-- ------------------------------------------------------------
-- VERIFICACION DE LOS TRES ESCENARIOS
-- ------------------------------------------------------------
SELECT
    'TOTAL SIMULADOS' AS escenario,
    COUNT(*) AS usuarios
FROM tb_users
WHERE email LIKE 't1\_%' OR email LIKE 't2\_%' OR email LIKE 't3\_%';

SELECT
    CASE
        WHEN email LIKE 't1\_%' THEN 'Test 1 (500 hombres US)'
        WHEN email LIKE 't2\_%' THEN 'Test 2 (2000 paises, 19-35)'
        WHEN email LIKE 't3\_%' THEN 'Test 3 (5000, 80/20)'
    END AS escenario,
    COUNT(*) AS total,
    SUM(status + 0) AS activos,
    SUM(1 - (status + 0)) AS inactivos
FROM tb_users
WHERE email LIKE 't1\_%' OR email LIKE 't2\_%' OR email LIKE 't3\_%'
GROUP BY escenario
ORDER BY escenario;

SELECT
    'Test 1: hombres de US' AS verificacion,
    COUNT(*) AS total
FROM tb_users u
JOIN tb_people p ON p.user_ID = u.ID
WHERE u.email LIKE 't1\_%'
  AND p.gender = 'Hombre'
  AND p.country_code = 'US';

SELECT
    'Test 2: edades entre 19 y 35' AS verificacion,
    COUNT(*) AS total,
    MIN(TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE())) AS edad_min,
    MAX(TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE())) AS edad_max,
    COUNT(DISTINCT p.country_code) AS paises_distintos
FROM tb_users u
JOIN tb_people p ON p.user_ID = u.ID
WHERE u.email LIKE 't2\_%';

SELECT
    'Test 3: proporcion activos' AS verificacion,
    COUNT(*) AS total,
    SUM(u.status + 0) AS activos,
    ROUND(100 * SUM(u.status + 0) / COUNT(*), 2) AS pct_activos
FROM tb_users u
WHERE u.email LIKE 't3\_%';

SELECT
    'Integridad tb_users <-> tb_people' AS verificacion,
    COUNT(*) AS usuarios_simulados,
    SUM(CASE WHEN p.user_ID IS NULL THEN 1 ELSE 0 END) AS sin_persona
FROM tb_users u
LEFT JOIN tb_people p ON p.user_ID = u.ID
WHERE u.email LIKE 't1\_%' OR u.email LIKE 't2\_%' OR u.email LIKE 't3\_%';

SELECT
    db_user,
    table_name,
    operation,
    COUNT(*) AS eventos
FROM tb_logs
WHERE table_name IN ('tb_users', 'tb_people')
  AND db_user LIKE 'remoto_superadmin%'
GROUP BY db_user, table_name, operation
ORDER BY table_name, operation;
