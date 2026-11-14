/* Página independiente del diagrama entidad-relación */
(() => {
  "use strict";

  const DATA = window.__DB_DATA__;
  if (!DATA) return;

  const $ = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));
  const state = { zoom: 1, baseWidth: 0, rendered: false };

  const DOMAIN_BY_ID = Object.fromEntries(DATA.domains.map((d) => [d.id, d]));

  function esc(value) {
    return String(value ?? "")
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#39;");
  }

  function fmt(number) {
    return Number(number || 0).toLocaleString("es-MX");
  }

  function renderStats() {
    $("#stat-tables").textContent = fmt(DATA.meta.tables);
    $("#stat-relations").textContent = fmt(DATA.meta.relations);
    $("#stat-domains").textContent = fmt(DATA.domains.length);
    $("#stat-rows").textContent = fmt(DATA.meta.totalRows);
    $("#fact-users").textContent = fmt(DATA.meta.users);
    $("#fact-products").textContent = fmt(DATA.meta.products);
    $("#fact-logs").textContent = fmt(DATA.meta.logs);
  }

  function renderDomainMap() {
    const container = $("#domain-map");
    if (!container) return;
    container.innerHTML = DATA.domains
      .map((domain) => {
        const tables = DATA.tables.filter((table) => table.domain === domain.id);
        if (!tables.length) return "";
        return `
          <div class="domain-column" style="--d-color:${domain.color};--d-soft:${domain.soft}">
            <div class="dc-head">
              <span class="dc-icon">${domain.icon}</span>
              <strong>${esc(domain.name)}</strong>
              <span>${tables.length}</span>
            </div>
            ${tables
              .map(
                (table) => `
                  <button class="map-table" data-goto="${esc(table.name)}" title="Abrir ficha de ${esc(table.name)}">
                    <span>${esc(table.name)}</span>
                    <span class="mt-rows">${table.rows ? fmt(table.rows) : "0"}</span>
                  </button>`
              )
              .join("")}
          </div>`;
      })
      .join("");
  }

  function relationCard(table, fk) {
    return `
      <article class="relation-card">
        <div class="rc-top">
          <code>${esc(table.name)}.${esc(fk.columns.join(" + "))}</code>
          <span class="arrow">→</span>
          <code class="target">${esc(fk.refTable)}.${esc(fk.refColumns.join(" + "))}</code>
          <span class="badge key-fk rel-card-badge">${esc(fk.cardinality || "N : 1")}</span>
        </div>
        <p>${esc(fk.description)}</p>
      </article>`;
  }

  function renderRelations() {
    const container = $("#relations-list");
    if (!container) return;
    const rows = [];
    for (const table of DATA.tables) {
      for (const fk of table.foreignKeys) rows.push({ table, fk });
    }
    container.innerHTML = `<div class="relations-grid">${rows
      .map(({ table, fk }) => relationCard(table, fk))
      .join("")}</div>`;
    $("#relations-info").textContent = `${rows.length} relaciones`;
  }

  function applyZoom() {
    const svg = $("#mermaid-diagram svg");
    if (!svg) return;
    if (!state.baseWidth) {
      const box = svg.viewBox && svg.viewBox.baseVal;
      state.baseWidth = box && box.width ? box.width : svg.getBoundingClientRect().width;
    }
    svg.style.width = `${Math.round(state.baseWidth * state.zoom)}px`;
    svg.style.height = "auto";
    svg.style.maxWidth = "none";
    $("#zoom-level").textContent = `${Math.round(state.zoom * 100)}%`;
  }

  async function renderMermaid() {
    if (state.rendered) return;
    const container = $("#mermaid-diagram");
    if (!container) return;
    if (!window.mermaid) {
      container.innerHTML = `<div class="mermaid-fallback">No se pudo cargar Mermaid. Revisa tu conexión a internet y recarga la página. El mapa por dominios y la lista de relaciones siguen disponibles.</div>`;
      return;
    }
    container.innerHTML = `<div class="mermaid-loading"><div class="spinner"></div>Cargando diagrama…</div>`;
    try {
      window.mermaid.initialize({
        startOnLoad: false,
        securityLevel: "loose",
        theme: "base",
        themeVariables: {
          fontFamily: "Inter, Segoe UI, sans-serif",
          primaryColor: "#eef4ff",
          primaryTextColor: "#0b1f3a",
          primaryBorderColor: "#7aa2ff",
          lineColor: "#94a3b8",
          secondaryColor: "#f8fafc",
          tertiaryColor: "#ffffff",
          edgeLabelBackground: "#ffffff",
          clusterBkg: "#f8fbff",
          clusterBorder: "#dfe8f3",
        },
        er: {
          diagramPadding: 24,
          layoutDirection: "TB",
          minEntityWidth: 150,
          minEntityHeight: 70,
          entityPadding: 14,
          useMaxWidth: false,
        },
      });
      const { svg } = await window.mermaid.render("erDiagramSvgStandalone", DATA.mermaid);
      container.innerHTML = svg;
      const svgEl = container.querySelector("svg");
      if (svgEl) {
        svgEl.style.maxWidth = "none";
        const box = svgEl.viewBox && svgEl.viewBox.baseVal;
        state.baseWidth = box && box.width ? box.width : svgEl.getBoundingClientRect().width;
        applyZoom();
      }
      state.rendered = true;
    } catch (error) {
      container.innerHTML = `<div class="mermaid-fallback">No se pudo dibujar el diagrama.<br><small>${esc(error.message || error)}</small></div>`;
    }
  }

  function downloadSvg() {
    const svg = $("#mermaid-diagram svg");
    if (!svg) return;
    const blob = new Blob([svg.outerHTML], { type: "image/svg+xml;charset=utf-8" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = "diagrama_er_respaldo1411.svg";
    document.body.appendChild(link);
    link.click();
    link.remove();
    URL.revokeObjectURL(url);
    toast("Diagrama SVG descargado");
  }

  function toast(message) {
    const node = $("#toast");
    if (!node) return;
    node.textContent = message;
    node.classList.add("show");
    clearTimeout(toast.timer);
    toast.timer = setTimeout(() => node.classList.remove("show"), 2400);
  }

  function bind() {
    $("#domain-map").addEventListener("click", (event) => {
      const button = event.target.closest("[data-goto]");
      if (button) {
        window.location.href = `diccionario_datos.html#tbl-${encodeURIComponent(button.dataset.goto)}`;
      }
    });

    $("#zoom-in").addEventListener("click", () => {
      state.zoom = Math.min(2.4, state.zoom + 0.15);
      applyZoom();
    });
    $("#zoom-out").addEventListener("click", () => {
      state.zoom = Math.max(0.45, state.zoom - 0.15);
      applyZoom();
    });
    $("#zoom-reset").addEventListener("click", () => {
      state.zoom = 1;
      applyZoom();
    });
    $("#download-svg").addEventListener("click", downloadSvg);
    $("#copy-mermaid").addEventListener("click", async () => {
      try {
        await navigator.clipboard.writeText(DATA.mermaid);
        toast("Código Mermaid copiado");
      } catch {
        toast("No se pudo copiar el código");
      }
    });
  }

  function init() {
    renderStats();
    renderDomainMap();
    renderRelations();
    bind();
    renderMermaid();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
