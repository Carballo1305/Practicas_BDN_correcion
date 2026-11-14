# Evidencias de ejecucion - Practica 03

**Fecha:** 12/11/2026  
**Servidor:** `127.0.0.1:40045` (MySQL 8.0.46)  
**Base de datos:** `db_test`

## 1. Objetos creados

| Objeto | Cantidad | Evidencia |
|--------|----------|-----------|
| Tablas base | 25 (24 operativas + `tb_logs`) | `07_verificacion/resultados_verificacion.txt` |
| Triggers | 72 (`trg_<tabla>_ai`, `_au`, `_ad`) | `02_triggers/02_triggers_72.sql` |
| Vistas | 25 (24 de trazabilidad + `vw_productos_por_categoria`) | `03_vistas/03_vistas_25.sql` |
| Roles | 7 | `04_usuarios_roles/04_usuarios_roles_privilegios.sql` |
| Funciones | 7 | `05_rutinas/05_procedimientos_funciones_eventos.sql` |
| Procedimientos | 6 | `05_rutinas/05_procedimientos_funciones_eventos.sql` |
| Eventos | 2 (ENABLED) | `07_verificacion/resultados_verificacion.txt` |

Salida literal de la verificacion:

```text
objeto                          total
Tablas base                     25
Tablas operativas (sin tb_logs) 24
Triggers                        72
Vistas                          25
Funciones                       7
Procedimientos                  6
Eventos                         2
```

## 2. Simulacion de usuarios

| Escenario | Usuarios | Activos | Inactivos |
|-----------|---------:|--------:|----------:|
| Test 1: 500 hombres de US | 500 | 500 | 0 |
| Test 2: 2,000 de 24 paises, edades 19-35 | 2,000 | 2,000 | 0 |
| Test 3: 5,000 con proporcion 80/20 | 5,000 | 4,006 | 994 |
| **Total** | **7,500** | | |

- Porcentaje de activos del Test 3: **80.12 %**.
- Los 7,500 usuarios simulados tienen registro en `tb_people` (`sin_persona = 0`, `estados_inconsistentes = 0`).

## 3. Poblacion de productos

| Vendedor | Productos | Descontinuados |
|----------|----------:|---------------:|
| `seller1` | 5,000 | 505 |
| `seller2` | 2,000 | 214 |
| **Total con vendedor** | **7,000** | **719** |

- Total de productos en el catalogo: **12,000** (incluye 5,000 productos heredados de practicas anteriores).
- Productos activos: **11,281**; descontinuados: **719**.
- Categorias o subcategorias sin productos: **0**.

## 4. Pruebas de acceso por rol

Archivo completo: `07_verificacion/09_pruebas_acceso.txt`.

| Prueba | Resultado |
|--------|-----------|
| `guest1` consulta `tb_products` y `vw_productos_por_categoria` | Permitido |
| `guest1` consulta `tb_users` y `vw_trazabilidad_usuarios` | Denegado (ERROR 1142) |
| `buyer1` consulta productos y carritos | Permitido |
| `buyer1` consulta `tb_logs` y `vw_trazabilidad_productos` | Denegado (ERROR 1142) |
| `seller1` consulta productos y `vw_trazabilidad_productos` | Permitido |
| `seller1` consulta `tb_orders`, elimina productos o lee trazabilidad de usuarios | Denegado (ERROR 1142) |
| `remoto_support` consulta las 25 vistas y `tb_logs` | Permitido |
| `remoto_support` elimina productos, crea tablas o crea usuarios | Denegado (ERROR 1142 / 1227) |
| `remoto_admin` consulta vistas y actualiza productos | Permitido |
| `remoto_admin` crea tablas (sin DDL) | Denegado (ERROR 1142) |
| `remoto_superadmin` crea y elimina una tabla | Permitido |

## 5. Integridad y calidad de datos

```text
Personas sin usuario                 0
Productos-categoria sin producto     0
Productos-categoria sin categoria    0
Proveedor-producto sin producto      0
Proveedor-producto sin usuario       0
Items de orden sin orden             0
Emails duplicados                    0
Nicks duplicados                     0
SKU duplicados                       0
Precios o stock invalidos            0
```

## 6. Trazabilidad

- Eventos registrados en `tb_logs`: **68,888**.
- Inserciones de usuarios por `remoto_superadmin`: **9,502**.
- Inserciones de productos por `seller1`: **5,004** y por `seller2`: **2,000**.
- La vista `vw_trazabilidad_usuarios` no expone `password`; muestra `nick` como `username`
  y enmascara referencias a metodos de pago.

## 7. Respaldos

Ver [`../backups/README.md`](../backups/README.md). Se generaron cinco respaldos:
inicial, esquema, usuarios, productos y final (22 MB).

El respaldo final se restauro en `db_test_restore_check` y se verifico:
25 tablas, 72 triggers, 25 vistas, 7,512 usuarios, 12,000 productos y
68,888 registros de bitacora. La base temporal se elimino despues de la prueba.
