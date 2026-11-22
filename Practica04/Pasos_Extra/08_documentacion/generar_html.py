# -*- coding: utf-8 -*-
"""Convierte los documentos Markdown de la Practica 03 a HTML autonomo."""
import html
import re
from pathlib import Path

import markdown

BASE = Path(__file__).resolve().parent.parent

DOCS = [
    BASE / "README.md",
    BASE / "08_documentacion" / "Informe_Practica03.md",
    BASE / "08_documentacion" / "EVIDENCIAS.md",
    BASE / "08_documentacion" / "diccionario_datos.md",
    BASE / "08_documentacion" / "mere.md",
    BASE / "backups" / "README.md",
]

CSS = """
:root { --azul:#123b6d; --azul2:#1f5fa8; --gris:#f4f6f9; --borde:#d8dee8; }
* { box-sizing: border-box; }
body { margin:0; background:#eef1f5; color:#1c2430;
       font-family: "Segoe UI", Roboto, Arial, sans-serif; line-height:1.6; }
main { max-width: 1150px; margin: 28px auto; background:#fff; padding: 46px 58px;
       box-shadow: 0 4px 24px rgba(0,0,0,.10); border-radius: 6px; }
h1 { color:var(--azul); border-bottom:3px solid var(--azul2); padding-bottom:.3em;
     font-size:2em; margin-top:0; }
h2 { color:var(--azul); border-bottom:1px solid var(--borde); padding-bottom:.2em;
     margin-top:2em; }
h3 { color:var(--azul2); margin-top:1.6em; }
h4 { color:#33475b; }
a { color:var(--azul2); }
table { border-collapse:collapse; width:100%; margin:1em 0; font-size:.94em; }
th, td { border:1px solid var(--borde); padding:8px 10px; text-align:left; vertical-align:top; }
th { background:var(--azul); color:#fff; font-weight:600; }
tr:nth-child(even) td { background:var(--gris); }
code { background:#eef2f7; padding:2px 5px; border-radius:3px; font-size:.92em;
       font-family: Consolas, "Courier New", monospace; }
pre { background:#1e2733; color:#e8eef7; padding:14px 18px; border-radius:6px;
      overflow-x:auto; font-size:.9em; }
pre code { background:transparent; color:inherit; padding:0; }
blockquote { border-left:4px solid var(--azul2); background:#eef4fb; margin:1em 0;
             padding:.6em 1em; color:#2c3e50; }
hr { border:0; border-top:1px solid var(--borde); margin:2em 0; }
.mermaid { background:#fff; border:1px solid var(--borde); border-radius:6px;
           padding:18px; margin:1.2em 0; overflow-x:auto; text-align:center; }
.portada { text-align:center; margin-bottom:1.5em; }
.portada .sub { color:#5b6b80; }
@media print {
  body { background:#fff; }
  main { box-shadow:none; margin:0; padding:0; max-width:none; }
  h1, h2, h3 { page-break-after:avoid; }
  table, pre, .mermaid { page-break-inside:avoid; }
}
"""

TEMPLATE = """<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{title}</title>
<style>{css}</style>
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
  mermaid.initialize({{ startOnLoad: true, theme: 'neutral' }});
</script>
</head>
<body>
<main>
{body}
</main>
</body>
</html>
"""


def convert(md_path: Path) -> Path:
    text = md_path.read_text(encoding="utf-8")
    body = markdown.markdown(
        text,
        extensions=["tables", "fenced_code", "sane_lists", "toc"],
        output_format="html5",
    )
    # Convertir bloques Mermaid en elementos que la libreria pueda renderizar.
    def mermaid_block(match):
        contenido = html.unescape(match.group(1))
        return f'<div class="mermaid">\n{contenido}\n</div>'
    body = re.sub(
        r'<pre><code class="language-mermaid">(.*?)</code></pre>',
        mermaid_block,
        body,
        flags=re.DOTALL,
    )
    # Enlaces internos de Markdown a HTML.
    body = re.sub(r'href="([^"]+)\.md(#[^"]*)?"', r'href="\1.html\2"', body)
    title = md_path.stem.replace("_", " ")
    html_path = md_path.with_suffix(".html")
    html_path.write_text(TEMPLATE.format(title=title, css=CSS, body=body), encoding="utf-8")
    return html_path


def build_index(paths):
    links = []
    for p in paths:
        if p.parent == BASE / "08_documentacion":
            href = p.name
        else:
            href = "../" + p.relative_to(BASE).as_posix()
        links.append(f'<li><a href="{href}">{p.stem.replace("_", " ")}</a></li>')
    body = (
        "<h1>Documentacion - Practica 03</h1>"
        "<p>Base de datos <code>db_test</code> - MySQL 8.0.46</p>"
        "<h2>Documentos</h2><ul>" + "".join(links) + "</ul>"
        "<h2>Accesos rapidos</h2><ul>"
        '<li><a href="archify/erd_practica03.html">Diagrama ER interactivo (Archify)</a></li>'
        '<li><a href="../README.html">README del proyecto</a></li>'
        '<li><a href="../07_verificacion/resultados_verificacion.txt">Resultados de verificacion</a></li>'
        '<li><a href="../07_verificacion/09_pruebas_acceso.txt">Pruebas de acceso</a></li>'
        '<li><a href="../backups/README.html">Respaldos</a></li>'
        "</ul>"
    )
    out = BASE / "08_documentacion" / "index.html"
    out.write_text(TEMPLATE.format(title="Documentacion Practica 03", css=CSS, body=body),
                   encoding="utf-8")
    return out


def main():
    generated = []
    for doc in DOCS:
        if doc.exists():
            generated.append(convert(doc))
            print("HTML:", generated[-1])
    index = build_index(generated)
    print("HTML:", index)


if __name__ == "__main__":
    main()
