# Informe de la Practica 03

**Materia:** Bases de datos en la nube  
**Practica:** 03 - Triggers, vistas, roles, simulacion y documentacion  
**Alumno:** Aaron Carballo  
**Fecha:** 12 de noviembre de 2026  
**Motor:** MySQL 8.0.46  
**Servidor:** `127.0.0.1:40045`  
**Base de datos:** `db_test`

---

## 1. Introduccion

La Practica 03 consolida el uso de objetos avanzados de MySQL sobre el esquema de
comercio electronico `db_test`. El trabajo abarca la correccion del modelo relacional,
la implementacion de 72 triggers de auditoria, 25 vistas de consulta y trazabilidad,
la definicion de siete roles con privilegios diferenciados, la creacion de funciones,
procedimientos y eventos, la simulacion de 7,500 usuarios y la poblacion de 7,000
productos por parte de dos vendedores remotos.

El objetivo general es demostrar que la base de datos no solo almacena informacion,
sino que tambien aplica reglas de negocio, registra trazabilidad, controla el acceso
y soporta procesos masivos de generacion de datos de prueba.

## 2. Objetivos especificos

1. Corregir las llaves foraneas y completar la tabla de bitacora.
2. Implementar 72 triggers (3 por tabla operativa) que registren INSERT, UPDATE y DELETE.
3. Crear 25 vistas: 24 de trazabilidad y 1 de catalogo por categoria.
4. Definir 7 roles y 8 cuentas remotas con privilegios de minimo privilegio.
5. Crear funciones, procedimientos y eventos para automatizar procesos.
6. Simular 7,500 usuarios en tres escenarios demograficos.
7. Poblar 7,000 productos distribuidos entre `seller1` y `seller2`.
8. Verificar integridad, duplicados, permisos y trazabilidad.
9. Generar respaldos y documentacion tecnica (diccionario de datos y MERE).

## 3. Entorno y metodologia

| Elemento | Valor |
|----------|-------|
| Servidor MySQL | 8.0.46 en `127.0.0.1:40045` |
| Cliente | `mysql` / `mysqldump` 8.0 |
| Base de datos | `db_test` |
| Configuracion | `C:\Users\Public\my_practica.cnf` |
| Control de versiones | Git local, rama `Practica03` |

Los scripts se ejecutaron en el orden documentado en el `README.md`. Cada actividad
genero un archivo de salida en `06_simulacion/` o `07_verificacion/` para conservar
la evidencia.

## 4. Desarrollo de las actividades

### Actividad 1. Correccion del esquema

Se conservaron las 25 tablas existentes. Se detecto que la llave foranea
`tbd_order_items.tbd_order_items_ibfk_1` apuntaba a una tabla inexistente
(`tb_buyer_orders`). Se elimino y se recreo como
`fk_order_items_order` hacia `tb_orders(ID)`.

Tambien se agrego a `tb_logs` la columna `record_id VARCHAR(150)` con su indice,
necesaria para relacionar cada evento con el registro afectado. El resultado fue
de 24 tablas operativas mas `tb_logs` (25 en total) y cero llaves foraneas huerfanas.

### Actividad 2. Triggers de auditoria

Se crearon 72 triggers con la convencion `trg_<tabla>_ai`, `trg_<tabla>_au` y
`trg_<tabla>_ad`. Cada trigger registra en `tb_logs`:

- tabla afectada,
- operacion (`INSERT`, `UPDATE`, `DELETE`),
- usuario de base de datos (`USER()`),
- identificador del registro (`record_id`),
- descripcion con los campos principales,
- fecha y estado.

Se verifico que las 24 tablas operativas tienen exactamente 3 triggers. `tb_logs`
no tiene triggers para evitar recursion.

### Actividad 3. Vistas

Se crearon 25 vistas:

- `vw_productos_por_categoria`: agrega productos por categoria con totales,
  activos, descontinuados y stock.
- 24 vistas `vw_trazabilidad_<tabla>`: combinan la entidad con su ultimo evento
  de bitacora.

La vista de usuarios excluye la columna `password`, expone `nick` como `username`
y enmascara las referencias a metodos de pago. Las vistas de trazabilidad se
restringieron a los roles `admin` y `support`; `seller` solo accede a las cinco
vistas de su dominio y los demas roles unicamente a la vista de catalogo.

### Actividad 4. Usuarios, roles y privilegios

Se definieron siete roles:

| Rol | Alcance |
|-----|---------|
| `superadmin` | Control total del servidor y de `db_test`. |
| `admin` | CRUD de las 24 tablas, lectura de bitacora y EXECUTE; sin DDL. |
| `support` | Consulta general y actualizacion de pedidos, envios y devoluciones. |
| `seller` | Productos, categorias de producto y proveedores. |
| `buyer` | Catalogo, carrito y pedidos propios. |
| `common_user` | Catalogo, perfil y carrito. |
| `user_not_registered` | Solo catalogo publico. |

Se crearon ocho cuentas remotas (`remoto_superadmin`, `remoto_admin`,
`remoto_support`, `seller1`, `seller2`, `buyer1`, `common1`, `guest1`) con su rol
asignado como predeterminado. Durante la revision se eliminaron privilegios amplios
heredados: `admin` tenia `ALL PRIVILEGES` sobre `db_test` y `support` podia crear
usuarios y administrar roles. Ambos se redujeron a los privilegios documentados.

### Actividad 5. Funciones, procedimientos y eventos

Se implementaron:

- **7 funciones** auxiliares para generar nombres, apellidos, paises, generos,
  fechas de nacimiento, numeros aleatorios y estados por probabilidad.
- **6 procedimientos**: `sp_simular_usuarios`, `sp_poblar_productos`,
  `sp_register_new_user`, `sp_soft_delete_product`, `sp_restore_product` y
  `sp_generar_72_triggers`.
- **2 eventos** habilitados: cierre de carritos inactivos (diario) y purga de
  bitacora antigua (semanal).

### Actividad 6. Simulacion de usuarios

Se generaron 7,500 usuarios en tres escenarios:

| Escenario | Usuarios | Activos | Inactivos |
|-----------|---------:|--------:|----------:|
| Test 1: 500 hombres de EE.UU. | 500 | 500 | 0 |
| Test 2: 2,000 de 24 paises, 19-35 anos | 2,000 | 2,000 | 0 |
| Test 3: 5,000 con 80/20 | 5,000 | 4,006 | 994 |
| **Total** | **7,500** | | |

Se corrigio un error de calculo de edad y se regenero el Test 2 para garantizar
que todos los usuarios quedaran dentro del rango de 19 a 35 anos. Los 7,500
usuarios tienen registro correspondiente en `tb_people`.

### Actividad 7. Poblacion de productos

Se generaron 7,000 productos nuevos:

| Vendedor | Productos | Descontinuados |
|----------|----------:|---------------:|
| `seller1` | 5,000 | 505 |
| `seller2` | 2,000 | 214 |
| **Total** | **7,000** | **719** |

Cada producto se asocio a una categoria y a su proveedor. El catalogo total quedo
en 12,000 productos (incluye 5,000 productos heredados de practicas anteriores),
con 11,281 activos y 719 descontinuados. Ninguna categoria quedo sin productos.

### Actividad 8. Verificacion

Se ejecutaron consultas de conteo, integridad, duplicados, permisos y trazabilidad.
Resultados principales:

```text
Tablas base 25 | Triggers 72 | Vistas 25 | Funciones 7 | Procedimientos 6 | Eventos 2
Usuarios simulados 7,500 | Productos 12,000 | Productos con vendedor 7,000
Registros de bitacora 68,888
Personas sin usuario 0 | FK huerfanas 0 | Emails/nick/SKU duplicados 0
Precios o stock invalidos 0 | Categorias sin productos 0
```

Las pruebas de acceso confirmaron que las cuentas solo pueden operar dentro de su
rol. Los intentos de lectura o escritura fuera de alcance devolvieron
`ERROR 1142` o `ERROR 1227`.

### Actividad 9. Respaldos

Se generaron cinco respaldos con `mysqldump`:

1. `backup_00_inicial` - estado previo a las correcciones.
2. `backup_01_esquema` - solo estructura.
3. `backup_02_usuarios` - usuarios, personas y relaciones.
4. `backup_03_productos` - productos, categorias y relaciones.
5. `backup_04_final` - respaldo completo (22 MB).

### Actividad 10. Documentacion

Se generaron:

- `diccionario_datos.md` y `diccionario_datos.csv` con las 25 tablas, 205 columnas,
  tipos, nulabilidad, llaves, valores por defecto y llaves foraneas.
- `mere.md` con entidades, relaciones, cardinalidades, reglas de negocio y diagrama
  Mermaid.
- `archify/erd_practica03.html` con el ERD interactivo standalone generado con
  Archify 3.2.0: 25 tablas, 205 columnas, roles PK/FK/UK y vistas por dominio.
- `EVIDENCIAS.md` con los resultados comprobados.
- Este informe y el `README.md` con el orden de ejecucion.

### Actividad 11. Control de versiones

Se inicializo un repositorio Git local. El trabajo se desarrollo en la rama
`Practica03` y se integro en `main` mediante `merge --no-ff`. Se creo la etiqueta
`practica03-final`. Ambas ramas se publicaron en
<https://github.com/Carballo1305/Practicas_BDN_correcion> y el repositorio remoto
conto con los ultimos commits de la practica.

## 5. Resultados y discusion

La base `db_test` cumple con los objetos y volumenes solicitados. La bitacora
registro 68,888 eventos, lo que demuestra que los triggers se disparan en las
operaciones reales de simulacion y poblacion. Las pruebas de acceso evidencian
una separacion efectiva de responsabilidades: el rol de soporte puede consultar
las 25 vistas, el vendedor solo las cinco de productos y los compradores e
invitados unicamente el catalogo.

La correccion del esquema elimino una llave foranea rota que podia impedir la
insercion de items de pedido. La incorporacion de `record_id` en `tb_logs`
mejora la trazabilidad y permite auditar un registro especifico sin depender
solo de la descripcion textual.

## 6. Conclusiones

1. Los triggers permiten auditar de forma automatica y consistente las 24 tablas
   operativas sin modificar el codigo de la aplicacion.
2. Las vistas de trazabilidad facilitan la consulta de auditoria y, al excluir
   datos sensibles, reducen el riesgo de exposicion de contrasenas.
3. El modelo de roles aplica el principio de minimo privilegio y es verificable
   mediante pruebas de acceso reproducibles.
4. Los procedimientos y funciones permiten generar volumenes grandes de datos
   de prueba con reglas demograficas controladas.
5. La documentacion generada a partir de `information_schema` se mantiene
   sincronizada con la base y facilita el mantenimiento.

## 7. Limitaciones

- El ERD de Archify muestra el tipo base `enum` en cada tabla y documenta los
  valores permitidos en una tarjeta; el diccionario de datos conserva el tipo
  completo.
- Los datos de pedidos, carritos, pagos y envios no se poblaron porque el alcance
  de la practica se centro en usuarios, productos y auditoria.
- Los scripts de poblacion de productos son aditivos y deben ejecutarse una sola vez.

## 8. Anexos

| Documento | Ruta |
|-----------|------|
| README del proyecto | `../README.md` |
| Diccionario de datos | `diccionario_datos.md` |
| Diccionario en CSV | `diccionario_datos.csv` |
| MERE | `mere.md` |
| ERD interactivo (Archify) | `archify/erd_practica03.html` |
| Captura del ERD | `archify/erd_practica03.png` |
| Especificacion ERD | `archify/candidate.json` |
| Evidencias | `EVIDENCIAS.md` |
| Verificacion completa | `../07_verificacion/resultados_verificacion.txt` |
| Validacion final | `../07_verificacion/validacion_final.txt` |
| Pruebas de acceso | `../07_verificacion/09_pruebas_acceso.txt` |
| Respaldos | `../backups/README.md` |
