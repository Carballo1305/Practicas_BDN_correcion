# Generador de documentación interactiva

Este directorio contiene el generador que produce, a partir de
`../respaldo1411.sql`:

- `../diccionario_datos.html` - diccionario interactivo de las 25 tablas.
- `../diagrama_er.html` - diagrama entidad-relación y relaciones explicadas.
- `../index_documentacion.html` - página de entrada a ambas vistas.

## Regenerar

```bash
cd Practica03/backups/docgen
python build.py
```

No requiere conexión a internet. El HTML usa Mermaid desde un CDN únicamente
para el diagrama técnico; el diccionario, el mapa por dominios y la lista de
relaciones funcionan sin conexión.

## Archivos

| Archivo | Función |
|---------|---------|
| `parser.py` | Lee el respaldo y extrae tablas, columnas, llaves, relaciones y conteos. |
| `meta.py` | Nombres amigables, dominios de negocio y descripciones de relaciones. |
| `columns.py` | Descripción en español de cada columna. |
| `samples.json` | Ejemplos de filas con datos sensibles ya enmascarados. |
| `build.py` | Ensambla los datos y escribe los tres HTML. |
| `styles.css` | Diseño visual compartido. |
| `app.js` | Buscador, filtros, fichas, zoom y pestañas del diccionario. |
| `diagram.js` | Lógica de la página independiente del diagrama. |
| `template_*.html` | Plantillas HTML de las tres páginas. |

## Privacidad

Los ejemplos de `samples.json` no contienen correos, teléfonos, contraseñas ni
referencias de pago reales. `build.py` vuelve a aplicar el enmascaramiento antes
de insertar los datos en el HTML.
