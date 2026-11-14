-- ============================================================
-- PRACTICA 03 - BASES DE DATOS EN LA NUBE
-- Actividad 5: Procedimientos almacenados, funciones y eventos
-- ============================================================
USE db_test;

-- ------------------------------------------------------------
-- FUNCIONES AUXILIARES REUTILIZABLES
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS fn_aleatorio_entero;
DELIMITER $$
CREATE FUNCTION fn_aleatorio_entero(p_min INT, p_max INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    IF p_min IS NULL OR p_max IS NULL OR p_max < p_min THEN
        RETURN NULL;
    END IF;
    RETURN p_min + FLOOR(RAND() * (p_max - p_min + 1));
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_genero_aleatorio;
DELIMITER $$
CREATE FUNCTION fn_genero_aleatorio()
RETURNS VARCHAR(20)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN ELT(fn_aleatorio_entero(1, 3),
               'Hombre', 'Mujer', 'Prefiero no decirlo');
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_pais_aleatorio;
DELIMITER $$
CREATE FUNCTION fn_pais_aleatorio()
RETURNS CHAR(2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN ELT(fn_aleatorio_entero(1, 24),
        'US','MX','CA','BR','AR','CO','CL','PE','ES','FR',
        'DE','IT','GB','PT','JP','CN','IN','KR','AU','NZ',
        'UY','EC','CR','PA');
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_nombre_aleatorio;
DELIMITER $$
CREATE FUNCTION fn_nombre_aleatorio(p_genero VARCHAR(20))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    IF p_genero = 'Hombre' THEN
        RETURN ELT(fn_aleatorio_entero(1, 20),
            'Carlos','Jose','Luis','Miguel','Jorge','Fernando','Ricardo','Alejandro',
            'Daniel','Andres','Roberto','Eduardo','Javier','Sergio','Raul','Marco',
            'Diego','Ivan','Pablo','Hector');
    ELSEIF p_genero = 'Mujer' THEN
        RETURN ELT(fn_aleatorio_entero(1, 20),
            'Maria','Ana','Laura','Sofia','Carmen','Lucia','Elena','Patricia',
            'Gabriela','Fernanda','Valeria','Daniela','Paola','Monica','Silvia',
            'Rosa','Adriana','Claudia','Isabel','Veronica');
    ELSE
        RETURN ELT(fn_aleatorio_entero(1, 10),
            'Alex','Sam','Jordan','Taylor','Casey','Robin','Dani','Andrea','Noel','Guille');
    END IF;
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_apellido_aleatorio;
DELIMITER $$
CREATE FUNCTION fn_apellido_aleatorio()
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN ELT(fn_aleatorio_entero(1, 24),
        'Garcia','Hernandez','Martinez','Lopez','Gonzalez','Perez','Rodriguez',
        'Sanchez','Ramirez','Torres','Flores','Rivera','Gomez','Diaz','Cruz',
        'Morales','Ortiz','Gutierrez','Chavez','Ramos','Vargas','Castillo',
        'Jimenez','Mendoza');
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_fecha_nacimiento;
DELIMITER $$
CREATE FUNCTION fn_fecha_nacimiento(p_edad_min INT, p_edad_max INT)
RETURNS DATE
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_fecha_min DATE;
    DECLARE v_fecha_max DATE;
    IF p_edad_min IS NULL OR p_edad_max IS NULL OR p_edad_min > p_edad_max THEN
        RETURN NULL;
    END IF;
    -- Fecha mas reciente que cumple la edad minima (la persona mas joven)
    SET v_fecha_min = DATE_SUB(CURDATE(), INTERVAL p_edad_min YEAR);
    -- Fecha mas antigua que aun cumple la edad maxima (la persona mayor)
    SET v_fecha_max = DATE_ADD(
        DATE_SUB(CURDATE(), INTERVAL (p_edad_max + 1) YEAR),
        INTERVAL 1 DAY
    );
    RETURN DATE_ADD(
        v_fecha_max,
        INTERVAL fn_aleatorio_entero(0, DATEDIFF(v_fecha_min, v_fecha_max)) DAY
    );
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_estado_probabilidad;
DELIMITER $$
CREATE FUNCTION fn_estado_probabilidad(p_prob_activo DECIMAL(5,2))
RETURNS BIT(1)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    IF p_prob_activo IS NULL OR p_prob_activo >= 100 THEN
        RETURN b'1';
    END IF;
    IF p_prob_activo <= 0 THEN
        RETURN b'0';
    END IF;
    IF (RAND() * 100) < p_prob_activo THEN
        RETURN b'1';
    END IF;
    RETURN b'0';
END$$
DELIMITER ;

-- ------------------------------------------------------------
-- PROCEDIMIENTO GENERAL DE SIMULACION MASIVA DE USUARIOS
-- Parametros:
--   p_cantidad     : obligatorio, cantidad de usuarios a generar.
--   p_genero       : opcional; NULL o '*' = aleatorio.
--   p_pais         : opcional; NULL o '*' = aleatorio (ISO-2).
--   p_edad_min     : opcional; NULL = 18.
--   p_edad_max     : opcional; NULL = 65.
--   p_prob_activo  : opcional; NULL = 100 (porcentaje de activos).
--   p_prefijo      : opcional; NULL = 'sim'.
--   p_rol          : opcional; NULL = 'common_user'.
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_simular_usuarios;
DELIMITER $$
CREATE PROCEDURE sp_simular_usuarios(
    IN p_cantidad     INT,
    IN p_genero       VARCHAR(20),
    IN p_pais         VARCHAR(2),
    IN p_edad_min     INT,
    IN p_edad_max     INT,
    IN p_prob_activo  DECIMAL(5,2),
    IN p_prefijo      VARCHAR(20),
    IN p_rol          VARCHAR(20)
)
BEGIN
    DECLARE v_i              INT DEFAULT 0;
    DECLARE v_user_id        INT;
    DECLARE v_token          VARCHAR(40);
    DECLARE v_email          VARCHAR(100);
    DECLARE v_nick           VARCHAR(50);
    DECLARE v_genero         VARCHAR(20);
    DECLARE v_genero_fila    VARCHAR(20);
    DECLARE v_pais           CHAR(2);
    DECLARE v_pais_fila      CHAR(2);
    DECLARE v_edad_min       INT;
    DECLARE v_edad_max       INT;
    DECLARE v_prob           DECIMAL(5,2);
    DECLARE v_prefijo        VARCHAR(20);
    DECLARE v_rol            VARCHAR(20);
    DECLARE v_status         BIT(1);
    DECLARE v_birth          DATE;
    DECLARE v_genero_rand    BOOLEAN DEFAULT FALSE;
    DECLARE v_pais_rand      BOOLEAN DEFAULT FALSE;
    DECLARE v_db_user        VARCHAR(100);
    DECLARE v_role_ok        INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Control de acceso por rol (root siempre puede)
    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);
    SELECT COUNT(*) INTO v_role_ok
    FROM mysql.role_edges
    WHERE TO_USER = v_db_user
      AND FROM_USER IN ('superadmin', 'admin', 'support');

    IF v_db_user <> 'root' AND v_role_ok = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: se requiere rol superadmin, admin o support';
    END IF;

    -- Validacion y valores por defecto de parametros
    IF p_cantidad IS NULL OR p_cantidad <= 0 OR p_cantidad > 100000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad debe estar entre 1 y 100000';
    END IF;

    SET v_genero = NULLIF(TRIM(p_genero), '');
    IF v_genero IS NULL OR v_genero = '*' THEN
        SET v_genero_rand = TRUE;
    ELSEIF v_genero NOT IN ('Hombre', 'Mujer', 'Prefiero no decirlo') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Genero invalido: use Hombre, Mujer, Prefiero no decirlo o *';
    END IF;

    SET v_pais = UPPER(NULLIF(TRIM(p_pais), ''));
    IF v_pais IS NULL OR v_pais = '*' THEN
        SET v_pais_rand = TRUE;
    ELSEIF v_pais NOT REGEXP '^[A-Z]{2}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pais invalido: use un codigo ISO de 2 letras o *';
    END IF;

    SET v_edad_min = COALESCE(p_edad_min, 18);
    SET v_edad_max = COALESCE(p_edad_max, 65);
    IF v_edad_min < 18 OR v_edad_max > 100 OR v_edad_min > v_edad_max THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rango de edad invalido (18 a 100 y minimo <= maximo)';
    END IF;

    SET v_prob = COALESCE(p_prob_activo, 100);
    IF v_prob < 0 OR v_prob > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La probabilidad de cuenta activa debe estar entre 0 y 100';
    END IF;

    SET v_prefijo = LEFT(COALESCE(NULLIF(TRIM(p_prefijo), ''), 'sim'), 12);
    SET v_rol = COALESCE(NULLIF(TRIM(p_rol), ''), 'common_user');

    START TRANSACTION;

    WHILE v_i < p_cantidad DO
        SET v_token = REPLACE(UUID(), '-', '');
        SET v_email = CONCAT(v_prefijo, '_', LEFT(v_token, 24), '@sim.test');
        SET v_nick  = CONCAT(v_prefijo, '_', LEFT(v_token, 12));

        IF v_genero_rand THEN
            SET v_genero_fila = fn_genero_aleatorio();
        ELSE
            SET v_genero_fila = v_genero;
        END IF;

        IF v_pais_rand THEN
            SET v_pais_fila = fn_pais_aleatorio();
        ELSE
            SET v_pais_fila = v_pais;
        END IF;

        SET v_birth  = fn_fecha_nacimiento(v_edad_min, v_edad_max);
        SET v_status = fn_estado_probabilidad(v_prob);

        INSERT INTO tb_users (email, nick, roles, password, status)
        VALUES (v_email, v_nick, v_rol, SHA2(v_token, 256), v_status);

        SET v_user_id = LAST_INSERT_ID();

        INSERT INTO tb_people (
            user_ID, given_names, family_names, birth_date, gender,
            country_code, phone, status
        ) VALUES (
            v_user_id,
            fn_nombre_aleatorio(v_genero_fila),
            fn_apellido_aleatorio(),
            v_birth,
            v_genero_fila,
            v_pais_fila,
            CONCAT('+', fn_aleatorio_entero(1, 99),
                   LPAD(fn_aleatorio_entero(0, 99999999), 8, '0')),
            v_status
        );

        SET v_i = v_i + 1;
    END WHILE;

    COMMIT;

    SELECT
        v_i              AS usuarios_generados,
        v_prefijo        AS prefijo,
        v_rol            AS rol_asignado,
        v_edad_min       AS edad_minima,
        v_edad_max       AS edad_maxima,
        v_prob           AS porcentaje_activo_objetivo,
        v_db_user        AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END$$
DELIMITER ;

-- ------------------------------------------------------------
-- PROCEDIMIENTO DE POBLACION MASIVA DE PRODUCTOS
-- Parametros:
--   p_cantidad          : obligatorio.
--   p_seller_email      : correo del usuario vendedor (tb_users).
--   p_prefijo_sku       : prefijo para SKU (opcional, 'PROD').
--   p_pct_descontinuado : porcentaje de productos con status b'0'.
--   p_precio_min/max    : rango de precios (opcional).
-- ------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_poblar_productos;
DELIMITER $$
CREATE PROCEDURE sp_poblar_productos(
    IN p_cantidad          INT,
    IN p_seller_email      VARCHAR(100),
    IN p_prefijo_sku       VARCHAR(20),
    IN p_pct_descontinuado DECIMAL(5,2),
    IN p_precio_min        DECIMAL(10,2),
    IN p_precio_max        DECIMAL(10,2)
)
BEGIN
    DECLARE v_i             INT DEFAULT 0;
    DECLARE v_product_id    INT UNSIGNED;
    DECLARE v_seller_id     INT;
    DECLARE v_seller_nick   VARCHAR(50);
    DECLARE v_num_cats      INT;
    DECLARE v_cat_seq       INT;
    DECLARE v_cat_id        INT UNSIGNED;
    DECLARE v_cat_name      VARCHAR(120);
    DECLARE v_parent_id     INT UNSIGNED;
    DECLARE v_parent_name   VARCHAR(120);
    DECLARE v_prefijo       VARCHAR(20);
    DECLARE v_pct           DECIMAL(5,2);
    DECLARE v_pmin          DECIMAL(10,2);
    DECLARE v_pmax          DECIMAL(10,2);
    DECLARE v_price         DECIMAL(10,2);
    DECLARE v_stock         INT;
    DECLARE v_status        BIT(1);
    DECLARE v_db_user       VARCHAR(100);
    DECLARE v_role_ok       INT DEFAULT 0;
    DECLARE v_descontinuados INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);
    SELECT COUNT(*) INTO v_role_ok
    FROM mysql.role_edges
    WHERE TO_USER = v_db_user
      AND FROM_USER IN ('superadmin', 'admin', 'seller');

    IF v_db_user <> 'root' AND v_role_ok = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: se requiere rol seller, admin o superadmin';
    END IF;

    IF p_cantidad IS NULL OR p_cantidad <= 0 OR p_cantidad > 100000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad de productos debe estar entre 1 y 100000';
    END IF;

    SELECT ID, nick INTO v_seller_id, v_seller_nick
    FROM tb_users
    WHERE email = p_seller_email
      AND status = b'1'
    LIMIT 1;

    IF v_seller_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El vendedor indicado no existe o esta inactivo';
    END IF;

    SELECT COUNT(*) INTO v_num_cats FROM tbc_categories;
    IF v_num_cats = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existen categorias para asignar productos';
    END IF;

    SET v_prefijo = LEFT(COALESCE(NULLIF(TRIM(p_prefijo_sku), ''), 'PROD'), 12);
    SET v_pct     = COALESCE(p_pct_descontinuado, 10);
    SET v_pmin    = COALESCE(p_precio_min, 10);
    SET v_pmax    = COALESCE(p_precio_max, 5000);

    IF v_pct < 0 OR v_pct > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El porcentaje de descontinuados debe estar entre 0 y 100';
    END IF;
    IF v_pmin < 0 OR v_pmax < v_pmin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rango de precios invalido';
    END IF;

    START TRANSACTION;

    WHILE v_i < p_cantidad DO
        SET v_cat_seq = v_i MOD v_num_cats;
        SELECT id, name INTO v_cat_id, v_cat_name
        FROM (
            SELECT id, name, ROW_NUMBER() OVER (ORDER BY id) AS rn
            FROM tbc_categories
        ) AS x
        WHERE rn = v_cat_seq + 1;

        SELECT sup_id_category INTO v_parent_id
        FROM tbc_categories WHERE id = v_cat_id;

        SET v_parent_name = NULL;
        IF v_parent_id IS NOT NULL THEN
            SELECT name INTO v_parent_name FROM tbc_categories WHERE id = v_parent_id;
        END IF;

        SET v_price  = v_pmin + ROUND(RAND() * (v_pmax - v_pmin), 2);
        SET v_stock  = fn_aleatorio_entero(0, 500);
        SET v_status = IF((RAND() * 100) < v_pct, b'0', b'1');

        INSERT INTO tb_products (
            SKU, name, description, current_price, current_stock, status
        ) VALUES (
            CONCAT(v_prefijo, '-', LPAD(v_i + 1, 6, '0'), '-', v_seller_id),
            CONCAT(v_cat_name, ' ', v_prefijo, ' ', LPAD(v_i + 1, 5, '0')),
            CONCAT('Producto generado para ', v_seller_nick,
                   '. Categoria: ', v_cat_name,
                   IF(v_parent_name IS NULL, '', CONCAT(' / ', v_parent_name))),
            v_price,
            v_stock,
            v_status
        );

        SET v_product_id = LAST_INSERT_ID();
        IF v_status = b'0' THEN
            SET v_descontinuados = v_descontinuados + 1;
        END IF;

        INSERT INTO tbd_products_users_providers (
            user_ID, product_ID, type_ownership, status, available_date, last_update
        ) VALUES (
            v_seller_id, v_product_id, 'Owner', b'1', NOW(), NOW()
        );

        INSERT INTO tbd_products_categories (
            product_ID, category_ID, status, creation_date, last_update
        ) VALUES (
            v_product_id, v_cat_id, b'1', NOW(), NOW()
        );

        -- Algunos productos se publican tambien en la categoria padre
        IF v_parent_id IS NOT NULL AND (v_i MOD 3 = 0) THEN
            INSERT IGNORE INTO tbd_products_categories (
                product_ID, category_ID, status, creation_date, last_update
            ) VALUES (
                v_product_id, v_parent_id, b'1', NOW(), NOW()
            );
        END IF;

        SET v_i = v_i + 1;
    END WHILE;

    COMMIT;

    SELECT
        v_i                  AS productos_insertados,
        v_seller_id          AS seller_id,
        p_seller_email       AS seller_email,
        v_descontinuados     AS productos_descontinuados,
        v_db_user            AS ejecutado_por,
        CURRENT_TIMESTAMP    AS fecha_operacion;
END$$
DELIMITER ;

-- ------------------------------------------------------------
-- EVENTOS PROGRAMADOS
-- ------------------------------------------------------------

DROP EVENT IF EXISTS ev_purgar_logs_antiguos;
CREATE EVENT ev_purgar_logs_antiguos
ON SCHEDULE EVERY 1 WEEK
STARTS (CURRENT_DATE + INTERVAL 1 WEEK + INTERVAL 3 HOUR)
ON COMPLETION PRESERVE
ENABLE
COMMENT 'Elimina registros de auditoria con mas de 180 dias'
DO
    DELETE FROM tb_logs
    WHERE operation_date < NOW() - INTERVAL 180 DAY;

DROP EVENT IF EXISTS ev_cerrar_carritos_inactivos;
CREATE EVENT ev_cerrar_carritos_inactivos
ON SCHEDULE EVERY 1 DAY
STARTS (CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 2 HOUR)
ON COMPLETION PRESERVE
ENABLE
COMMENT 'Desactiva carritos sin actividad y sin ordenes despues de 90 dias'
DO
    UPDATE tb_carts c
    SET c.status = b'0',
        c.last_update = NOW()
    WHERE c.status = b'1'
      AND c.creation_date < NOW() - INTERVAL 90 DAY
      AND NOT EXISTS (
          SELECT 1 FROM tb_orders o WHERE o.buyer_ID = c.user_ID
      );

-- ------------------------------------------------------------
-- VERIFICACION DE RUTINAS Y EVENTOS
-- ------------------------------------------------------------
SELECT ROUTINE_NAME, ROUTINE_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'db_test'
ORDER BY ROUTINE_TYPE, ROUTINE_NAME;

SELECT EVENT_NAME, STATUS, INTERVAL_VALUE, INTERVAL_FIELD
FROM information_schema.EVENTS
WHERE EVENT_SCHEMA = 'db_test'
ORDER BY EVENT_NAME;
