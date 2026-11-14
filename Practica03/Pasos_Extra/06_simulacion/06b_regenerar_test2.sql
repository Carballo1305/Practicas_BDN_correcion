-- Regeneracion del Test 2 con la funcion de edad corregida
USE db_test;

DELETE p FROM tb_people p
JOIN tb_users u ON u.ID = p.user_ID
WHERE u.email LIKE 't2\_%';

DELETE FROM tb_users WHERE email LIKE 't2\_%';

CALL sp_simular_usuarios(2000, '*', '*', 19, 35, 100, 't2', 'common_user');

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
    'TOTAL SIMULADOS' AS escenario,
    COUNT(*) AS usuarios
FROM tb_users
WHERE email LIKE 't1\_%' OR email LIKE 't2\_%' OR email LIKE 't3\_%';
