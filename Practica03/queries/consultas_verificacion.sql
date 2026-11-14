USE db_test;
/*1. Cuantas tablas existen en la base de datos db_test*/
SHOW TABLES;

/*2. Cunatos triggers existen en la base de datos db_test*/
SHOW TRIGGERS FORM db_test;

/*3. Cuantos registros existen en la tabla users*/
SELECT COUNT(*) AS total_registros FROM tb_users;

/*4. Cuantos reguistros existen em la tabla bitacora*/
SELECT COUNT (*) AS total_registros FROM tb_logs;

/*5.Consultar todas las operaciones*/
SELECT * FROM tb_logs;
/*6. Verificar que los usuarios remotos hayan sido creados */
SELECT USER, HOST FROM mysql.user where Host='%' AND account_locked= 'N';

/*7. Verificar los roles que fueron creados */
SELECT User, HOST FROM mysql.user where HOST = '%' AND account_locked = 'Y';

/*8. Verificar que usuarios tienen que roles  */
SELECT TO_USER AS usuario, TO HOST AS HOST, FROM_USER AS rol, FROM_HOST AS rol_host 
FROM mysql.role_edges ORDER BY TO_USER, FROM_USER;


/* Agregando el rol 8 del SGBD */
SELECT
    u.nick,
    u.email,
    b.db_user AS inserted_by,
    GROUP_CONCAT(
        DISTINCT re.FROM_USER
        ORDER BY re.FROM_USER
        SEPARATOR ', '
    ) AS roles,
    b.table_operation,
    b.operation_date
FROM tb_users u
JOIN tb_logs b
    ON b.table_description LIKE CONCAT('%', u.nick, '%')
    AND b.table_operation LIKE CONCAT('%', u.email, '%')
LEFT JOIN mysql.role_edges re
    ON re.TO_USER = SUBSTRING_INDEX(b.db_user, '@', 1)
WHERE b.table_opera tion = 'Create'
  AND b.table_name = 'tb_users'
GROUP BY 
    u.nick, 
    u.email,
    b.db_user, 
    b.table_description, 
    b.table_operation,
    b.operation_date 
ORDER BY b.operation_date ASC;

SELECT * FROM tb_products;
SELECT
p.id,
p.name,
p.description,
b.db_user AS inserted_by,

COALESCE(
    GROUP_CONCAT(
        DISTINCT re.FROM_USER
        ORDER BY re.FROM_USER
         SEPARATOR ', '
         ), 
         'no hay roles bro') 
         AS roles,

    b.table_operation,
    b.operation_date

    FROM tb_products p

    JOIN tb_logs b
    ON b.table_description LIKE CONCAT(
        '%', p.name, '%'
        )
LEFT JOIN mysql.role_edges re
    ON re.TO_USER = SUBSTRING_INDEX(b.db_user, '@', 1)
    WHERE b.table_operation = 'Create'
    AND b.table_name = 'tb_products'

  GROUP BY 
    p.id, 
    p.name, 
    p.description,
    b.db_user, 
    b.table_description, 
    b.table_operation,
    b.operation_date

          