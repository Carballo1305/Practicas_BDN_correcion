# Respaldos de `db_test`

Respaldos generados con `mysqldump` (MySQL 8.0.46) el 12/11/2026.

| Archivo | Contenido | Tamaño |
|---------|-----------|--------|
| `backup_00_inicial_20261112.sql` | Respaldo completo previo a las correcciones de la Practica 03. | 6.1 MB |
| `backup_01_esquema_20261112.sql` | Solo estructura: 25 tablas, 72 triggers, 25 vistas, rutinas y eventos (`--no-data`). | 0.24 MB |
| `backup_02_usuarios_20261112.sql` | Datos de usuarios y personas: `tb_users`, `tb_people`, direcciones, metodos de pago y wishlist. | 2.3 MB |
| `backup_03_productos_20261112.sql` | Datos de catalogo: `tb_products`, `tbc_categories` y tablas de relacion. | 4.9 MB |
| `backup_04_final_20261112.sql` | Respaldo completo final: estructura + datos + triggers + vistas + rutinas + eventos. | 22 MB |
| `respaldo1411.sql` | Copia renombrada del respaldo final usada como fuente de la documentación interactiva. | 23 MB |

## Documentación interactiva

La documentación de la base de datos se puede abrir directamente en el navegador:

- `index_documentacion.html` - página de entrada con enlaces a las dos vistas.
- `diccionario_datos.html` - diccionario interactivo: 25 tablas, columnas, tipos SQL, llaves, relaciones y ejemplos con datos sensibles enmascarados.
- `diagrama_er.html` - diagrama entidad-relación: mapa por dominios, diagrama técnico con zoom y descarga SVG, y lista de las 37 relaciones.

Los archivos se generan con los scripts de `docgen/` a partir de `respaldo1411.sql`:

```bash
python docgen/build.py
```

## Respaldos heredados

En esta misma carpeta se conservan sin modificaciones:

- `respaldo 2010.sql` - respaldo de una version anterior de `db_test`.
- `respaldo1510.sql` - respaldo previo adicional.

El respaldo vigente de la Practica 03 es `backup_04_final_20261112.sql`.

## Restauracion

Restauracion completa en una base limpia:

```bash
mysql -h 127.0.0.1 -P 40045 -u root -p -e "CREATE DATABASE db_test_restaurada;"
mysql -h 127.0.0.1 -P 40045 -u root -p db_test_restaurada < backup_04_final_20261112.sql
```

Restauracion solo de estructura:

```bash
mysql -h 127.0.0.1 -P 40045 -u root -p db_test < backup_01_esquema_20261112.sql
```

## Prueba de restauracion

El respaldo final se restauro en la base temporal `db_test_restore_check` y se
verifico su contenido antes de eliminarla:

```text
tablas  triggers  vistas  usuarios  productos  logs
25      72        25      7,512     12,000     68,888
```

La restauracion completo en 8.5 segundos y no reporto errores.

## Notas

- Los respaldos no incluyen las cuentas ni los roles de MySQL (`mysql.user`, `mysql.role_edges`),
  porque `mysqldump` no exporta el esquema `mysql`. Las cuentas y privilegios se recrean con
  `../04_usuarios_roles/04_usuarios_roles_privilegios.sql`.
- `--set-gtid-purged=OFF` evita incluir informacion de GTID para facilitar la restauracion.
- Los archivos `err0*.txt` se generaron vacios, lo que confirma que `mysqldump` no reporto errores.
