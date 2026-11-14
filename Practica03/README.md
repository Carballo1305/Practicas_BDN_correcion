# Practica 03 - Bases de datos en la nube

Implementacion completa de la Practica 03 sobre la base de datos `db_test`
(MySQL 8.0.46, servidor `127.0.0.1:40045`): correccion del esquema, 72 triggers,
25 vistas, 7 roles con privilegios, rutinas y eventos, simulacion de 7,500 usuarios,
poblacion de 7,000 productos por vendedores y verificacion integral.

El enlace del diccionario de datos de la actividad esta aqui:
### Diagrama Entidad-Relación 
* **[Ver Diagrama ER en pantalla completa](https://carballo1305.github.io/Practicas_BDN_correcion/Practica03/backups/diagrama_er.html)**

## Contenido del repositorio

```text
Practica03/
├── 01_schema/
│   └── 01_correccion_esquema.sql          Correccion de FK y tabla tb_logs
├── 02_triggers/
│   └── 02_triggers_72.sql                 72 triggers de auditoria
├── 03_vistas/
│   └── 03_vistas_25.sql                   25 vistas (24 trazabilidad + catalogo)
├── 04_usuarios_roles/
│   └── 04_usuarios_roles_privilegios.sql  7 roles, 8 cuentas remotas y privilegios
├── 05_rutinas/
│   └── 05_procedimientos_funciones_eventos.sql  7 funciones, 6 procedimientos, 2 eventos
├── 06_simulacion/
│   ├── 06_simulacion_usuarios.sql         Simulacion de 7,500 usuarios (3 escenarios)
│   ├── 06b_regenerar_test2.sql            Regeneracion del Test 2 (edades 19-35)
│   ├── 07a_poblacion_seller1.sql          5,000 productos como seller1
│   ├── 07b_poblacion_seller2.sql          2,000 productos como seller2
│   └── resultado_*.txt                    Salidas de cada proceso
├── 07_verificacion/
│   ├── 08_consultas_verificacion.sql      Consultas de verificacion
│   ├── 09_pruebas_acceso.ps1              Pruebas automatizadas de acceso
│   ├── 09_pruebas_acceso.txt              Resultados de las pruebas de acceso
│   └── resultados_verificacion.txt        Resultados de la verificacion
├── 08_documentacion/
│   ├── diccionario_datos.md               Diccionario de datos legible
│   ├── diccionario_datos.csv              Diccionario de datos para Excel
│   ├── mere.md                            MERE con diagrama Mermaid
│   ├── EVIDENCIAS.md                      Resumen de resultados comprobados
│   ├── Informe_Practica03.md              Informe completo de la practica
│   ├── generar_documentacion.py           Generador de la documentacion
│   └── archify/
│       ├── build_archify_erd.py           Generador del ERD Archify
│       ├── candidate.json                 Especificacion ERD validada
│       ├── erd_practica03.html            ERD interactivo standalone
│       └── erd_practica03.png             Captura del ERD para el informe
└── backups/
    ├── backup_00_inicial_20261112.sql
    ├── backup_01_esquema_20261112.sql
    ├── backup_02_usuarios_20261112.sql
    ├── backup_03_productos_20261112.sql
    ├── backup_04_final_20261112.sql
    └── README.md
```

## Requisitos

- MySQL Server 8.0.46 en `127.0.0.1:40045`.
- Cliente `mysql` y `mysqldump` en el PATH (o rutas completas de MySQL 8.0).
- `event_scheduler = ON` y privilegios de administrador para crear roles, usuarios y eventos.

## Conexion

| Parametro | Valor |
|-----------|-------|
| Host | `127.0.0.1` |
| Puerto | `40045` |
| Base de datos | `db_test` |
| Usuario administrador | `root` |
| Contrasena administrador | `root1234` |

Archivo de configuracion usado por los scripts:

```ini
# C:\Users\Public\my_practica.cnf
[client]
host=127.0.0.1
port=40045
user=root
password=root1234
default-character-set=utf8mb4
```

## Orden de ejecucion

Ejecutar desde una consola con el cliente MySQL:

```bash
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 01_schema/01_correccion_esquema.sql
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 02_triggers/02_triggers_72.sql
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 03_vistas/03_vistas_25.sql
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 04_usuarios_roles/04_usuarios_roles_privilegios.sql
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 05_rutinas/05_procedimientos_funciones_eventos.sql
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 06_simulacion/06_simulacion_usuarios.sql
# Solo si se requiere regenerar el Test 2:
# mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 06_simulacion/06b_regenerar_test2.sql
# Poblacion de productos (ejecutar como seller1 y seller2):
mysql --defaults-file="C:\Users\Public\my_seller1.cnf" db_test < 06_simulacion/07a_poblacion_seller1.sql
mysql --defaults-file="C:\Users\Public\my_seller2.cnf" db_test < 06_simulacion/07b_poblacion_seller2.sql
mysql --defaults-file="C:\Users\Public\my_practica.cnf" db_test < 07_verificacion/08_consultas_verificacion.sql
powershell -ExecutionPolicy Bypass -File 07_verificacion/09_pruebas_acceso.ps1
```

> **Importante:** si se vuelven a crear los procedimientos con `DROP PROCEDURE`,
> se pierden los permisos `EXECUTE` a nivel de rutina. En ese caso se debe re-ejecutar
> `04_usuarios_roles_privilegios.sql` para restaurar los permisos de `seller`.
>
> La simulacion de usuarios es repetible: elimina los usuarios `t1_`, `t2_` y `t3_`
> antes de regenerarlos. La poblacion de productos es **aditiva**; ejecutarla dos veces
> duplica los productos de cada vendedor, por lo que debe correrse una sola vez.

## Cuentas y roles

### Roles del sistema

| Rol | Proposito |
|-----|-----------|
| `superadmin` | Control total del servidor y de `db_test`. |
| `admin` | CRUD sobre las 24 tablas operativas, lectura de bitacora y ejecucion de rutinas; sin DDL. |
| `support` | Consulta general y actualizacion de pedidos, envios, devoluciones y cancelaciones. |
| `seller` | Gestion de productos, categorias de producto y proveedores. |
| `buyer` | Consulta de catalogo y gestion de carrito y pedidos propios. |
| `common_user` | Catalogo, perfil propio y carrito. |
| `user_not_registered` | Solo catalogo publico. |

### Cuentas remotas

| Usuario | Rol | Contrasena |
|---------|-----|------------|
| `remoto_superadmin` | `superadmin` | `Sup3r#2026` |
| `remoto_admin` | `admin` | `Adm1n#2026` |
| `remoto_support` | `support` | `Supp0rt#2026` |
| `seller1` | `seller` | `Sell3r1#2026` |
| `seller2` | `seller` | `Sell3r2#2026` |
| `buyer1` | `buyer` | `Buy3r1#2026` |
| `common1` | `common_user` | `C0mm0n#2026` |
| `guest1` | `user_not_registered` | `Gu3st1#2026` |

Todas las cuentas usan el host `%` y tienen su rol asignado como rol predeterminado.
Las contrasenas con `#` deben ir entre comillas dobles en los archivos `.cnf`.
MySQL muestra los roles como cuentas bloqueadas (`account_locked = 'Y'`); es el
comportamiento normal de los roles y no impide su uso por las cuentas asignadas.

### Usuarios de aplicacion de los vendedores

| Email | Nick | Contrasena (SHA-256 en `tb_users`) |
|-------|------|-------------------------------------|
| `seller1@ecommerce.test` | `seller1` | `Seller1#2026` |
| `seller2@ecommerce.test` | `seller2` | `Seller2#2026` |

## Matriz de acceso a objetos

| Objeto | superadmin | admin | support | seller | buyer | common_user | guest |
|--------|:----------:|:-----:|:-------:|:------:|:-----:|:-----------:|:-----:|
| 24 tablas operativas | CRUD | CRUD | SELECT (+UPDATE en pedidos/envios/devoluciones) | productos y relaciones | catalogo, carrito, pedidos propios | catalogo, perfil, carrito | catalogo |
| `tb_logs` | CRUD | SELECT | SELECT | SELECT | - | - | - |
| 25 vistas | SELECT | SELECT | SELECT | 5 vistas de productos | 1 vista de catalogo | 1 vista de catalogo | 1 vista de catalogo |
| Rutinas | EXECUTE | EXECUTE | - | 3 procedimientos de productos | - | - | - |
| DDL / usuarios | Si | No | No | No | No | No | No |

## Resultados verificados

| Indicador | Resultado |
|-----------|-----------|
| Tablas base | 25 (24 operativas + `tb_logs`) |
| Triggers | 72 |
| Vistas | 25 |
| Roles | 7 |
| Funciones / procedimientos / eventos | 7 / 6 / 2 |
| Usuarios simulados | 7,500 |
| Usuarios con registro en `tb_people` | 7,500 |
| Productos totales | 12,000 (11,281 activos, 719 descontinuados) |
| Productos asignados a vendedores | 7,000 (seller1: 5,000; seller2: 2,000) |
| Categorias sin productos | 0 |
| Registros de auditoria | 68,888 |
| Llaves foraneas huerfanas / duplicados | 0 |

El detalle y las salidas literales estan en
[`08_documentacion/EVIDENCIAS.md`](08_documentacion/EVIDENCIAS.md),
[`07_verificacion/resultados_verificacion.txt`](07_verificacion/resultados_verificacion.txt)
y la validacion consolidada en
[`07_verificacion/validacion_final.txt`](07_verificacion/validacion_final.txt)
(script: [`07_verificacion/10_validacion_final.sql`](07_verificacion/10_validacion_final.sql)).

## Vistas

- **Catalogo:** `vw_productos_por_categoria`.
- **Trazabilidad (24):** una vista por tabla operativa
  (`vw_trazabilidad_usuarios`, `vw_trazabilidad_people`, `vw_trazabilidad_productos`,
  `vw_trazabilidad_categorias`, `vw_trazabilidad_productos_categorias`,
  `vw_trazabilidad_products_users_providers`, `vw_trazabilidad_carts`,
  `vw_trazabilidad_cart_items`, `vw_trazabilidad_orders`, `vw_trazabilidad_order_items`,
  `vw_trazabilidad_payments`, `vw_trazabilidad_payment_methods`,
  `vw_trazabilidad_payment_methods_types`, `vw_trazabilidad_user_payment_methods`,
  `vw_trazabilidad_payment_transaction`, `vw_trazabilidad_shipments`,
  `vw_trazabilidad_returns`, `vw_trazabilidad_return_items`, `vw_trazabilidad_refunds`,
  `vw_trazabilidad_user_addresses`, `vw_trazabilidad_address_components`,
  `vw_trazabilidad_order_cancellations`, `vw_trazabilidad_cancellation_items`,
  `vw_trazabilidad_users_wishlist_products`).

Las vistas de trazabilidad incluyen los datos de la entidad y las columnas
`log_id`, `log_operation`, `log_db_user`, `log_record_id`, `log_description`,
`log_date` y `log_status`. La vista de usuarios excluye `password` y enmascara
las referencias a metodos de pago.

## Version HTML de la documentacion

Los documentos tambien estan disponibles en HTML con tablas, codigo y diagrama Mermaid:

- [`08_documentacion/index.html`](08_documentacion/index.html) - indice general.
- [`08_documentacion/Informe_Practica03.html`](08_documentacion/Informe_Practica03.html) - informe completo.
- [`08_documentacion/mere.html`](08_documentacion/mere.html) - MERE con diagrama.
- [`08_documentacion/diccionario_datos.html`](08_documentacion/diccionario_datos.html) - diccionario de datos.
- [`08_documentacion/archify/erd_practica03.html`](08_documentacion/archify/erd_practica03.html) - ERD interactivo generado con Archify.
- [`README.html`](README.html) - esta guia en HTML.

### Diagrama ER interactivo con Archify

El ERD de [`08_documentacion/archify/erd_practica03.html`](08_documentacion/archify/erd_practica03.html)
se genero con **Archify 3.2.0** a partir de `backups/respaldo1411.sql`. Incluye las
25 tablas, 205 columnas, los roles PK/FK/UK, las 36 relaciones dibujables y vistas
por dominio. La auto-referencia de `tbd_address_components` y los valores de los
`ENUM` se documentan en tarjetas para no perder informacion.

- Especificacion validada: [`08_documentacion/archify/candidate.json`](08_documentacion/archify/candidate.json).
- Generador: [`08_documentacion/archify/build_archify_erd.py`](08_documentacion/archify/build_archify_erd.py).
- Receipts de validacion: `erd_practica03.finalize.json` y `erd_practica03.browser-check.json`.

### Documentacion interactiva desde `respaldo1411.sql`

Tambien hay una version interactiva generada directamente desde el respaldo
[`backups/respaldo1411.sql`](backups/respaldo1411.sql):

- [`backups/index_documentacion.html`](backups/index_documentacion.html) - entrada con enlaces a las dos vistas.
- [`backups/diccionario_datos.html`](backups/diccionario_datos.html) - diccionario de las 25 tablas con buscador, filtros, llaves, tipos SQL y ejemplos enmascarados.
- [`backups/diagrama_er.html`](backups/diagrama_er.html) - diagrama entidad-relacion con mapa por dominios, zoom, descarga SVG y las 37 relaciones explicadas.

Para regenerarlos:

```bash
python 08_documentacion/generar_html.py
python backups/docgen/build.py
python 08_documentacion/archify/build_archify_erd.py
# Finalizar con Archify 3.2.0:
# node <ruta-a-archify>/bin/archify.mjs finalize erd \
#   08_documentacion/archify/candidate.json \
#   08_documentacion/archify/erd_practica03.html --quality standard
```

> El diagrama Mermaid usa la libreria publica de jsDelivr; el resto del HTML funciona sin conexion.

## Respaldos

> En `backups/` tambien se conservan los respaldos heredados `respaldo 2010.sql` y
> `respaldo1510.sql`, que corresponden a versiones anteriores de `db_test` y no se
> modificaron. El respaldo vigente de esta practica es `backup_04_final_20261112.sql`.

Ver [`backups/README.md`](backups/README.md). Se incluyen respaldos inicial,
de esquema, de usuarios, de productos y final (22 MB).

## Limitaciones y pendientes

- **GitHub:** la rama `Practica03` y la rama `main` ya se publicaron en
  <https://github.com/Carballo1305/Practicas_BDN_correcion>. El repositorio remoto
  contiene los ultimos commits de la practica.
- **Archify:** el ERD interactivo se genero con Archify 3.2.0 y paso las puertas
  `validate`, `deliver`, `check` y `browser-check`. El tipo base `enum` se muestra
  en la tabla y los valores permitidos se detallan en una tarjeta; el diccionario
  de datos conserva el tipo completo.
- Los privilegios heredados sobre la base `db_test_7b` (practicas anteriores) se
  conservaron intactos; no forman parte de esta practica.
- Los datos de ejemplo de pedidos, carritos, pagos y envios no se poblaron porque
  el alcance solicitado se centro en usuarios y productos.
