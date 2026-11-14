
-- 1. Creación de usuarios
CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'qwerty123';
CREATE USER IF NOT EXISTS 'aaron.carballo'@'%' IDENTIFIED BY '240045';
CREATE USER IF NOT EXISTS 'mario.banda'@'%' IDENTIFIED BY '240597';
CREATE USER IF NOT EXISTS 'samuel.vargas'@'%' IDENTIFIED BY '240023';
CREATE USER IF NOT EXISTS 'ricardin.gabriel'@'%' IDENTIFIED BY '240349';
CREATE USER IF NOT EXISTS 'Rene.Cabrera'@'%' IDENTIFIED BY '240107';
CREATE USER IF NOT EXISTS 'Jona.Eliel'@'%' IDENTIFIED BY '240080';
CREATE USER IF NOT EXISTS 'obed.vargas'@'%' IDENTIFIED BY '240145';


-- 2. Creación de roles
CREATE ROLE IF NOT EXISTS 'superadmin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


-- 3. Configuración del rol ADMIN
GRANT ALL PRIVILEGES ON db_test.* TO 'admin';
GRANT ALL PRIVILEGES ON db_test.* TO 'superadmin';


-- 4. Configuración del rol SUPPORT
GRANT SHOW DATABASES, CREATE USER, ROLE_ADMIN ON *.* TO 'support';
GRANT SELECT, INSERT, UPDATE, SHOW VIEW ON db_test.* TO 'support';


-- 5. Configuración del rol SELLER
GRANT SELECT, INSERT, UPDATE ON db_test.tb_products TO 'seller';


-- 6. Asignación de roles a usuarios
GRANT 'admin' TO 'marco.ramirez'@'%';
GRANT 'support' TO 'mario.banda'@'%';
GRANT 'seller' TO 'Rene.Cabrera'@'%';
GRANT 'seller' TO 'obed.vargas'@'%'; #seller2
GRANT 'seller' TO 'Jona.Eliel'@'%'; #seller1
GRANT 'superadmin' TO 'aaron.carballo'@'%';


-- 7. Permisos globales directos para Super Admin
GRANT ALL PRIVILEGES ON *.* TO 'aaron.carballo'@'%'
WITH GRANT OPTION;


-- 8. Activar roles por defecto al iniciar sesión
SET DEFAULT ROLE ALL TO 'marco.ramirez'@'%';
SET DEFAULT ROLE ALL TO 'Rene.Cabrera'@'%';
SET DEFAULT ROLE ALL TO 'mario.banda'@'%';
SET DEFAULT ROLE ALL TO 'obed.vargas'@'%';
SET DEFAULT ROLE ALL TO 'aaron.carballo'@'%';
SET DEFAULT ROLE ALL TO 'Jona.Eliel'@'%';


-- 9. Aplicar cambios
FLUSH PRIVILEGES;