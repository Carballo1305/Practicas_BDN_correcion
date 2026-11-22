# ERD interactivo con Archify

Este directorio contiene el diagrama entidad-relación standalone de la Práctica 03,
generado con **Archify 3.2.0** a partir de `../../backups/respaldo1411.sql`.

## Archivos

| Archivo | Contenido |
|---------|-----------|
| `erd_practica03.html` | ERD interactivo autocontenido (temas claro/oscuro, vistas por dominio y exportación). |
| `erd_practica03.png` | Captura completa del ERD para el informe. |
| `candidate.json` | Especificación ERD validada por Archify. |
| `build_archify_erd.py` | Generador del candidato desde el respaldo SQL. |
| `erd_practica03.delivery.json` | Receipt de entrega del artefacto. |
| `erd_practica03.finalize.json` | Receipt de la finalización y sus puertas de validación. |
| `erd_practica03.finalize-summary.json` | Resumen del receipt anterior. |
| `erd_practica03.browser-check.json` | Receipt del browser-check automatizado. |

## Cobertura

- 25 tablas y 205 columnas físicas.
- 37 llaves foráneas declaradas: 36 relaciones dibujables y una auto-referencia
  en `tbd_address_components`.
- Roles `PK`, `FK` y `UK` por columna.
- Vistas por dominio: usuarios/auditoría, catálogo, compras/envíos, pagos y posventa.
- Los valores de los `ENUM` se documentan en una tarjeta; el tipo base `enum`
  permanece visible en la tabla.

## Regeneración

Desde la raíz de `Practica03`:

```bash
python 08_documentacion/archify/build_archify_erd.py
node <ruta-a-archify>/bin/archify.mjs finalize erd \
  08_documentacion/archify/candidate.json \
  08_documentacion/archify/erd_practica03.html --quality standard
```

La validación final debe reportar `validate`, `deliver`, `check` y
`browser-check` en estado `pass`.
