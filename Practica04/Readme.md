## Vista en Vivo (GitHub Pages)

Puedes visualizar e interactuar directamente con el diccionario de datos y el diagrama entidad-relación desde tu navegador haciendo clic en los siguientes enlaces:

* **[Ver Diccionario de Datos Interactivo](https://carballo1305.github.io/Practicas_BDN_correcion/Practica04/diccionario_datos.html)** — Haz clic aquí para explorar las tablas, columnas, tipos de datos y descripciones de `respaldo2011.sql`.
* **[Ver Diagrama Entidad-Relación (ER)](https://carballo1305.github.io/Practicas_BDN_correcion/Practica04/diagrama_er.html)** — Haz clic aquí para visualizar el esquema gráfico de relaciones y llaves entre entidades.

📁 Práctica 04: Ingeniería Inversa y Documentación Interactiva de Base de Datos (respaldo2011.sql)

Este proyecto contiene la documentación técnica y funcional generada a partir del respaldo de base de datos respaldo2011.sql. El objetivo principal es traducir la estructura técnica de la base de datos a herramientas visuales e interactivas comprensibles tanto para equipos de desarrollo como para personal de negocio, administración y operaciones.

🎯 Objetivos de la Práctica

Análisis e Ingeniería Inversa: Extraer la estructura completa (tablas, columnas, tipos de datos, llaves primarias/foráneas y conteo real de registros) desde el script SQL respaldo2011.sql.

Traducción Funcional (Sin Jerga Técnica): Inferir el propósito de negocio de cada entidad y atributo para ofrecer descripciones claras en lenguaje cotidiano, conservando intactos los nombres técnicos originales.

Visualización Interactiva: Actualizar y entregar dos herramientas web autocontenidas (diccionario_datos.html y diagrama_er.html) que faciliten la exploración de datos y sus relaciones.

📂 Estructura de Archivos Entregables

Practica04/
├── backups/
│   └── respaldo2011.sql         # Script SQL fuente con la estructura y registros de la BD
├── diccionario_datos.html       # Diccionario de datos extendido, buscable e interactivo
├── diagrama_er.html             # Diagrama Entidad-Relación (ER) visual e interactivo
└── README.md                    # Documentación general del proyecto


🛠️ Componentes Desarrollados

1. Diccionario de Datos Extendido e Interactivo (diccionario_datos.html)

Archivo web diseñado bajo estándares de UI/UX modernos para consultar el catálogo completo de la base de datos sin necesidad de conocimientos avanzados en SQL:

Nomenclatura Dual: Muestra el nombre técnico exacto de cada tabla y columna (ej. tbl_usuarios, fec_reg) acompañado de su explicación funcional en lenguaje cotidiano.

Inferencia de Negocio: Documentación automática del propósito de cada campo basándose en su tipo de dato, restricciones y valores de ejemplo en el respaldo.

Indicadores Visuales (Badges): Etiquetas intuitivas para identificar rápidamente tipos de datos (📝 Texto, 🔢 Número, 📅 Fecha, ✅ Booleano) y restricciones (PK Llave Primaria, FK Llave Foránea, NOT NULL Obligatorio, NULL Opcional).

Conteo Real de Registros: Cálculo exacto del volumen de registros (INSERT) almacenados por tabla dentro de respaldo2011.sql.

Relaciones Explicadas: Descripción en lenguaje natural de cómo se vincula cada tabla con el resto del sistema.

Experiencia Interactiva: Buscador en tiempo real, filtros por tabla y animaciones fluidas de despliegue/colapso.

2. Diagrama Entidad-Relación Interactivo (diagrama_er.html)

Representación gráfica de la arquitectura relacional de respaldo2011.sql:

Mapeo Completo de Entidades: Nodos individuales por cada tabla con sus atributos, tipos SQL, llaves (PK / FK) y conteo de registros actualizado.

Trazado de Relaciones: Conexiones visuales entre llaves foráneas y primarias que permiten comprender la cardinalidad y el flujo de información entre módulos.

Controles de Navegación: Herramientas interactivas de zoom, desplazamiento (panning) y resaltado de conexiones para explorar esquemas extensos con comodidad.

🚀 Cómo Visualizar los Resultados

Al tratarse de archivos HTML autocontenidos, no requieren instalación de servidores ni dependencias externas:

Ubica la carpeta del proyecto en tu equipo.

Haz doble clic sobre diccionario_datos.html para abrirlo en tu navegador web predeterminado (Chrome, Brave, Edge, Firefox) y explorar las tablas y definiciones.

Haz doble clic sobre diagrama_er.html para inspeccionar de forma gráfica el mapa de relaciones de la base de datos.

📝 Notas Técnicas

Fuente de Verdad: Toda la información técnica, tipos de datos y volúmenes de registros provienen directamente del análisis de respaldo2011.sql.

Compatibilidad: Compatible con cualquier navegador moderno con soporte para HTML5, CSS3 y JavaScript ES6+.
