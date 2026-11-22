/* Diccionario interactivo - lógica de interfaz */
(() => {
  "use strict";

  const DATA = window.__DB_DATA__;
  if (!DATA) return;

  const $ = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));
  const state = {
    query: "",
    domain: "all",
    onlyData: false,
    view: "diccionario",
    open: new Set(["tb_users"]),
    mermaidRendered: false,
    zoom: 1,
    baseWidth: 0,
    toastTimer: null,
  };

  const DOMAIN_BY_ID = Object.fromEntries(DATA.domains.map((d) => [d.id, d]));
  const TABLE_BY_NAME = Object.fromEntries(DATA.tables.map((t) => [t.name, t]));
  const MONEY_WORDS = ["price", "amount", "subtotal", "total", "shipping_total", "current_price"];

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

  function highlight(text, query) {
    const safe = esc(text);
    if (!query) return safe;
    const needle = esc(query).toLowerCase();
    const haystack = safe.toLowerCase();
    const index = haystack.indexOf(needle);
    if (index < 0) return safe;
    return (
      safe.slice(0, index) +
      "<mark>" +
      safe.slice(index, index + needle.length) +
      "</mark>" +
      safe.slice(index + needle.length)
    );
  }

  function typeInfo(type, columnName) {
    const raw = String(type || "").toLowerCase();
    const name = String(columnName || "").toLowerCase();
    if (raw.startsWith("bit") || raw.startsWith("tinyint(1)")) {
      return { cls: "type-bool", label: "Sí/No", icon: "✅" };
    }
    if (raw.startsWith("enum")) {
      return { cls: "type-enum", label: "Lista", icon: "📋" };
    }
    if (raw.startsWith("json")) {
      return { cls: "type-json", label: "JSON", icon: "🧩" };
    }
    if (raw.startsWith("date") || raw.startsWith("timestamp") || raw.startsWith("time") || raw.startsWith("year")) {
      return { cls: "type-date", label: "Fecha", icon: "📅" };
    }
    if (raw.startsWith("varchar") || raw.startsWith("char") || raw.includes("text")) {
      return { cls: "type-text", label: "Texto", icon: "📝" };
    }
    if (MONEY_WORDS.some((word) => name.includes(word))) {
      return { cls: "type-money", label: "Monto", icon: "💰" };
    }
    if (raw.startsWith("int") || raw.startsWith("bigint") || raw.startsWith("smallint") || raw.startsWith("tinyint") || raw.startsWith("decimal") || raw.startsWith("numeric") || raw.startsWith("float") || raw.startsWith("double")) {
      return { cls: "type-number", label: "Número", icon: "🔢" };
    }
    if (raw.startsWith("binary") || raw.startsWith("varbinary") || raw.includes("blob")) {
      return { cls: "type-binary", label: "Binario", icon: "💾" };
    }
    return { cls: "type-other", label: "Dato", icon: "🔧" };
  }

  function fkColumns(table) {
    const set = new Set();
    for (const fk of table.foreignKeys) {
      for (const col of fk.columns) set.add(col);
    }
    return set;
  }

  function columnBadges(table, column) {
    const badges = [];
    if (column.primaryKey) badges.push('<span class="badge key-pk">🔑 PK</span>');
    if (fkColumns(table).has(column.name)) badges.push('<span class="badge key-fk">🔗 FK</span>');
    if (column.unique) badges.push('<span class="badge key-uq">✨ Único</span>');
    if (column.uniqueComposite && !column.primaryKey) {
      badges.push('<span class="badge key-uq" title="Forma parte de una llave única compuesta">🧩 Único en conjunto</span>');
    }
    badges.push(
      column.notNull
        ? '<span class="badge badge-req">Obligatorio</span>'
        : '<span class="badge badge-opt">Opcional</span>'
    );
    if (column.autoIncrement) badges.push('<span class="badge badge-auto">Auto</span>');
    if (column.default !== null && String(column.default).toUpperCase() !== "NULL") {
      badges.push(`<span class="badge badge-default">Por defecto: ${esc(column.default)}</span>`);
    }
    return badges.join("");
  }

  function relationCard(table, fk, query) {
    const source = `${table.name}.${fk.columns.join(" + ")}`;
    const target = `${fk.refTable}.${fk.refColumns.join(" + ")}`;
    const cardinality = fk.cardinality || "N : 1";
    return `
      <article class="relation-card">
        <div class="rc-top">
          <code>${highlight(source, query)}</code>
          <span class="arrow">→</span>
          <code class="target">${highlight(target, query)}</code>
          <span class="badge key-fk rel-card-badge">${esc(cardinality)}</span>
        </div>
        <p>${highlight(fk.description, query)}</p>
      </article>`;
  }

  function relationsFor(table, query) {
    if (!table.foreignKeys.length) {
      return `<div class="sample-empty">Esta tabla no tiene llaves foráneas directas. Se conecta con la bitácora de auditoría mediante triggers.</div>`;
    }
    const items = table.foreignKeys
      .map((fk) => {
        const source = `${table.name}.${fk.columns.join(" + ")}`;
        const target = `${fk.refTable}.${fk.refColumns.join(" + ")}`;
        return `
          <div class="rel-item">
            <div class="rel-link">
              <span>${highlight(source, query)}</span>
              <span class="arrow">→</span>
              <span class="target">${highlight(target, query)}</span>
              <span class="badge key-fk rel-card-badge">${esc(fk.cardinality || "N : 1")}</span>
            </div>
            <p>${highlight(fk.description, query)}</p>
          </div>`;
      })
      .join("");
    return `<div class="rel-list">${items}</div>`;
  }

  const SENSITIVE_COLUMNS = new Set([
    "password",
    "provider_method_ref",
    "gateway_transaction_id",
    "gateway_response",
    "refund_reference",
    "last_four",
  ]);

  function maskValue(tableName, key, value) {
    if (value === null || value === undefined) return "NULL";
    const text = String(value);
    if (SENSITIVE_COLUMNS.has(key)) return "••••••••";
    if (tableName === "tb_users" && key === "email") {
      return text.replace(/^(.{1,2}).*(@.*)$/, "$1•••$2");
    }
    if (tableName === "tb_people" && key === "phone") {
      return text.replace(/^(\+\d{2}).*(\d{2})$/, "$1••••••$2");
    }
    if (tableName === "tb_logs" && key === "description" && text.length > 170) {
      return text.slice(0, 170) + "…";
    }
    return text;
  }

  function sampleBlock(table, query) {
    if (!table.sample) {
      return `<div class="sample-empty">Esta tabla todavía no tiene registros en el respaldo.</div>`;
    }
    const entries = Object.entries(table.sample)
      .map(([key, value]) => {
        const masked = maskValue(table.name, key, value);
        return `
          <div class="sample-item">
            <span class="k">${highlight(key, query)}</span>
            <span class="v">${highlight(masked, query)}</span>
          </div>`;
      })
      .join("");
    return `
      <details class="sample">
        <summary>👀 Ver ejemplo de registro (datos sensibles protegidos)</summary>
        <div class="sample-grid">${entries}</div>
      </details>`;
  }

  function tableCard(table, query) {
    const domain = DOMAIN_BY_ID[table.domain] || DATA.domains[0];
    const open = state.open.has(table.name);
    const rowsLabel = table.rows > 0 ? `${fmt(table.rows)} registros` : "Sin registros";
    const columns = table.columns
      .map((column) => {
        const info = typeInfo(column.type, column.name);
        return `
          <tr>
            <td class="col-name" data-label="Columna"><code>${highlight(column.name, query)}</code></td>
            <td class="col-type" data-label="Tipo">
              <span class="badge ${info.cls}">${info.icon} ${info.label}</span>
              <div class="type-raw">${esc(column.type)}</div>
            </td>
            <td class="col-badges" data-label="Atributos">${columnBadges(table, column)}</td>
            <td class="col-desc" data-label="¿Para qué sirve?">${highlight(column.description, query)}</td>
          </tr>`;
      })
      .join("");

    return `
      <article class="table-card ${open ? "open" : ""}" id="tbl-${esc(table.name)}" data-table="${esc(table.name)}" style="--d-color:${domain.color};--d-soft:${domain.soft}">
        <button class="table-head" data-toggle="${esc(table.name)}" aria-expanded="${open}" aria-controls="body-${esc(table.name)}">
          <span class="table-icon" aria-hidden="true">${table.icon || domain.icon}</span>
          <span class="table-title">
            <span class="table-name">${highlight(table.name, query)} <span class="friendly">${highlight(table.friendly, query)}</span></span>
            <span class="table-desc">${highlight(table.description, query)}</span>
          </span>
          <span class="table-meta">
            <span class="pill ${table.rows > 0 ? "rows" : "empty"}">${table.rows > 0 ? "●" : "○"} ${rowsLabel}</span>
            <span class="pill domain">${domain.icon} ${esc(domain.name)}</span>
          </span>
          <span class="chevron" aria-hidden="true">⌄</span>
        </button>
        <div class="table-body" id="body-${esc(table.name)}">
          <div class="table-body-inner">
            <div class="table-body-pad">
              <div class="columns-wrap">
                <table class="columns">
                  <thead>
                    <tr><th>Columna</th><th>Tipo SQL</th><th>Atributos</th><th>¿Para qué sirve?</th></tr>
                  </thead>
                  <tbody>${columns}</tbody>
                </table>
              </div>
              <div class="relations">
                <h4>🔗 Relaciones de esta tabla</h4>
                ${relationsFor(table, query)}
              </div>
              ${sampleBlock(table, query)}
            </div>
          </div>
        </div>
      </article>`;
  }

  function matches(table, query) {
    if (!query) return true;
    const needle = query.toLowerCase();
    const haystack = [
      table.name,
      table.friendly,
      table.description,
      ...table.columns.flatMap((c) => [c.name, c.type, c.description]),
      ...table.foreignKeys.flatMap((fk) => [fk.refTable, fk.description, ...fk.columns, ...fk.refColumns]),
    ]
      .join(" ")
      .toLowerCase();
    return haystack.includes(needle);
  }

  function filteredTables() {
    const query = state.query.trim().toLowerCase();
    return DATA.tables.filter((table) => {
      if (state.domain !== "all" && table.domain !== state.domain) return false;
      if (state.onlyData && table.rows === 0) return false;
      return matches(table, query);
    });
  }

  function renderDictionary() {
    const query = state.query.trim().toLowerCase();
    const visible = filteredTables();
    const container = $("#dictionary-list");
    const groups = new Map();
    for (const table of visible) {
      if (!groups.has(table.domain)) groups.set(table.domain, []);
      groups.get(table.domain).push(table);
    }

    if (!visible.length) {
      container.innerHTML = `
        <div class="empty-state">
          <span class="big">🔎</span>
          No encontramos tablas o columnas con “${esc(state.query)}”.
          <br><small>Prueba con otro término o cambia los filtros.</small>
        </div>`;
    } else {
      container.innerHTML = DATA.domains
        .filter((domain) => groups.has(domain.id))
        .map((domain) => {
          const tables = groups.get(domain.id);
          return `
            <section class="domain-group" id="dom-${esc(domain.id)}">
              <div class="domain-head" style="--d-color:${domain.color};--d-soft:${domain.soft}">
                <span class="domain-icon" aria-hidden="true">${domain.icon}</span>
                <div>
                  <h3>${esc(domain.name)}</h3>
                  <p>${esc(domain.description)}</p>
                </div>
                <span class="domain-count">${tables.length} tabla${tables.length === 1 ? "" : "s"}</span>
              </div>
              ${tables.map((table) => tableCard(table, query)).join("")}
            </section>`;
        })
        .join("");
    }

    const total = DATA.tables.length;
    $("#result-info").textContent = `${visible.length} de ${total} tablas · ${fmt(DATA.meta.totalRows)} registros en total`;
  }

  function renderChips() {
    const chips = [
      `<button class="chip ${state.domain === "all" ? "active" : ""}" data-domain="all">🧭 Todas <span class="count">${DATA.tables.length}</span></button>`,
      ...DATA.domains.map((domain) => {
        const count = DATA.tables.filter((t) => t.domain === domain.id).length;
        return `<button class="chip ${state.domain === domain.id ? "active" : ""}" data-domain="${esc(domain.id)}">${domain.icon} ${esc(domain.name)} <span class="count">${count}</span></button>`;
      }),
    ];
    $("#domain-chips").innerHTML = chips.join("");
  }

  function renderStats() {
    $("#stat-tables").textContent = fmt(DATA.meta.tables);
    $("#stat-rows").textContent = fmt(DATA.meta.totalRows);
    $("#stat-relations").textContent = fmt(DATA.meta.relations);
    $("#stat-with-data").textContent = fmt(DATA.meta.withData);
    $("#fact-users").textContent = fmt(DATA.meta.users);
    $("#fact-products").textContent = fmt(DATA.meta.products);
    $("#fact-logs").textContent = fmt(DATA.meta.logs);
    $("#fact-categories").textContent = fmt(DATA.meta.categories);
  }

  function renderDomainMap() {
    const container = $("#domain-map");
    if (!container) return;
    container.innerHTML = DATA.domains
      .map((domain) => {
        const tables = DATA.tables.filter((t) => t.domain === domain.id);
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
                  <button class="map-table" data-goto="${esc(table.name)}">
                    <span>${esc(table.name)}</span>
                    <span class="mt-rows">${table.rows ? fmt(table.rows) : "0"}</span>
                  </button>`
              )
              .join("")}
          </div>`;
      })
      .join("");
  }

  function renderRelations() {
    const query = state.query.trim().toLowerCase();
    const rows = [];
    for (const table of DATA.tables) {
      for (const fk of table.foreignKeys) {
        const haystack = [table.name, fk.refTable, fk.description, ...fk.columns, ...fk.refColumns].join(" ").toLowerCase();
        if (!query || haystack.includes(query)) rows.push({ table, fk });
      }
    }
    const container = $("#relations-list");
    if (!rows.length) {
      container.innerHTML = `<div class="empty-state"><span class="big">🔎</span>No hay relaciones que coincidan con “${esc(state.query)}”.</div>`;
    } else {
      container.innerHTML = `<div class="relations-grid">${rows.map(({ table, fk }) => relationCard(table, fk, query)).join("")}</div>`;
    }
    $("#relations-info").textContent = `${rows.length} de ${DATA.meta.relations} relaciones`;
  }

  function setView(view) {
    if (!["diccionario", "diagrama", "relaciones"].includes(view)) view = "diccionario";
    state.view = view;
    $$(".tab").forEach((tab) => tab.classList.toggle("active", tab.dataset.view === view));
    $$(".view").forEach((section) => section.classList.toggle("active", section.dataset.view === view));
    if (view === "diagrama") {
      renderMermaid();
    }
    if (view === "relaciones") {
      renderRelations();
    }
    const hash = view === "diccionario" ? "" : `#${view}`;
    history.replaceState(null, "", `${location.pathname}${hash}`);
  }

  async function renderMermaid() {
    if (state.mermaidRendered) return;
    const container = $("#mermaid-diagram");
    if (!container) return;
    if (!window.mermaid) {
      container.innerHTML = `<div class="mermaid-fallback">No se pudo cargar el motor de diagramas (Mermaid). Revisa tu conexión a internet y recarga la página. El diccionario y las relaciones siguen funcionando sin conexión.</div>`;
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
      const { svg } = await window.mermaid.render("erDiagramSvg", DATA.mermaid);
      container.innerHTML = svg;
      const svgEl = container.querySelector("svg");
      if (svgEl) {
        svgEl.style.maxWidth = "none";
        const box = svgEl.viewBox && svgEl.viewBox.baseVal;
        state.baseWidth = box && box.width ? box.width : svgEl.getBoundingClientRect().width;
        applyZoom();
      }
      state.mermaidRendered = true;
    } catch (error) {
      container.innerHTML = `<div class="mermaid-fallback">No se pudo dibujar el diagrama automáticamente.<br><small>${esc(error.message || error)}</small></div>`;
    }
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

  function downloadSvg() {
    const svg = $("#mermaid-diagram svg");
    if (!svg) return;
    const blob = new Blob([svg.outerHTML], { type: "image/svg+xml;charset=utf-8" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = "diagrama_er_respaldo2011.svg";
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
    clearTimeout(state.toastTimer);
    state.toastTimer = setTimeout(() => node.classList.remove("show"), 2400);
  }

  function goToTable(name) {
    state.domain = "all";
    state.onlyData = false;
    state.query = "";
    const search = $("#search-input");
    if (search) search.value = "";
    $("#search").classList.remove("has-value");
    state.open.add(name);
    renderChips();
    renderDictionary();
    setView("diccionario");
    const card = document.getElementById(`tbl-${name}`);
    if (card) {
      card.classList.add("open");
      const button = $(".table-head", card);
      if (button) button.setAttribute("aria-expanded", "true");
      setTimeout(() => card.scrollIntoView({ behavior: "smooth", block: "start" }), 60);
    }
  }

  function bind() {
    $("#search-input").addEventListener("input", (event) => {
      state.query = event.target.value;
      $("#search").classList.toggle("has-value", Boolean(state.query));
      renderDictionary();
      if (state.view === "relaciones") renderRelations();
    });

    $("#clear-search").addEventListener("click", () => {
      state.query = "";
      $("#search-input").value = "";
      $("#search").classList.remove("has-value");
      renderDictionary();
      if (state.view === "relaciones") renderRelations();
      $("#search-input").focus();
    });

    $("#domain-chips").addEventListener("click", (event) => {
      const chip = event.target.closest("[data-domain]");
      if (!chip) return;
      state.domain = chip.dataset.domain;
      renderChips();
      renderDictionary();
    });

    $("#only-data").addEventListener("change", (event) => {
      state.onlyData = event.target.checked;
      renderDictionary();
    });

    $("#expand-all").addEventListener("click", () => {
      state.open = new Set(filteredTables().map((table) => table.name));
      renderDictionary();
    });

    $("#collapse-all").addEventListener("click", () => {
      state.open.clear();
      renderDictionary();
    });

    $("#dictionary-list").addEventListener("click", (event) => {
      const button = event.target.closest("[data-toggle]");
      if (!button) return;
      const name = button.dataset.toggle;
      if (state.open.has(name)) state.open.delete(name);
      else state.open.add(name);
      const card = button.closest(".table-card");
      if (card) {
        card.classList.toggle("open", state.open.has(name));
        button.setAttribute("aria-expanded", String(state.open.has(name)));
      }
    });

    $$(".tab").forEach((tab) => tab.addEventListener("click", () => setView(tab.dataset.view)));

    $("#domain-map").addEventListener("click", (event) => {
      const button = event.target.closest("[data-goto]");
      if (button) goToTable(button.dataset.goto);
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

    document.addEventListener("keydown", (event) => {
      if (event.key === "/" && !["INPUT", "TEXTAREA"].includes(document.activeElement.tagName)) {
        event.preventDefault();
        $("#search-input").focus();
      }
      if (event.key === "Escape") {
        state.query = "";
        $("#search-input").value = "";
        $("#search").classList.remove("has-value");
        renderDictionary();
        if (state.view === "relaciones") renderRelations();
      }
    });
  }

  function init() {
    renderStats();
    renderChips();
    renderDictionary();
    renderDomainMap();
    renderRelations();
    bind();
    const hash = location.hash.replace("#", "");
    if (hash.startsWith("tbl-")) {
      goToTable(hash.slice(4));
    } else if (["diagrama", "relaciones"].includes(hash)) {
      setView(hash);
    } else {
      setView("diccionario");
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
