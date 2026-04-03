import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons

Item {
  id: root

  property var pluginApi: null
  property var cfg: pluginApi?.pluginSettings || ({})
  property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})

  property bool isLoading: false
  property string selectedSourceId: cfg.defaultSourceId || defaults.defaultSourceId || ""
  property var sourcesData: []

  function setStatus(message, errorText) {
    if (!pluginApi?.pluginSettings) return;
    pluginApi.pluginSettings.lastStatus = message || "Idle";
    pluginApi.pluginSettings.lastError = errorText || "";
  }

  function getConfiguredSources() {
    return cfg.sources || defaults.sources || [];
  }

  function slugify(text) {
    return String(text || "item")
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "") || "item";
  }

  function parseCodeToken(token) {
    var value = String(token || "").trim();
    if (!value.length) return { keys: [], command: "" };
    var looksLikeCommand = value.indexOf(" ") >= 0 || value.indexOf(":") === 0 || value.indexOf("/") >= 0;
    return looksLikeCommand ? { keys: [], command: value } : { keys: [value], command: "" };
  }

  function parseMarkdownLine(line, index) {
    var raw = String(line || "").trim();
    if (!raw.startsWith("- ")) return null;

    var body = raw.substring(2).trim();
    var match = body.match(/^`([^`]+)`\s+[—-]\s+(.+)$/);
    if (match) {
      var parsed = parseCodeToken(match[1]);
      return {
        id: "item-" + index + "-" + slugify(match[2]),
        title: match[2],
        description: match[2],
        keys: parsed.keys,
        command: parsed.command,
        tags: []
      };
    }

    return {
      id: "item-" + index + "-" + slugify(body),
      title: body,
      description: "",
      keys: [],
      command: "",
      tags: []
    };
  }

  function normalizeMarkdownContent(sourceCfg, content) {
    var lines = String(content || "").split(/\r?\n/);
    var sections = [];
    var currentSection = null;
    var sourceTitle = sourceCfg.title || sourceCfg.id;
    var introBuffer = [];
    var inCodeBlock = false;

    function ensureSection() {
      if (!currentSection) {
        currentSection = {
          id: "general",
          title: "General",
          description: "",
          items: []
        };
      }
    }

    for (var i = 0; i < lines.length; i++) {
      var raw = lines[i];
      var line = raw.trim();
      if (!line.length) continue;

      if (line.startsWith("```")) {
        inCodeBlock = !inCodeBlock;
        continue;
      }

      if (inCodeBlock) {
        ensureSection();
        currentSection.items.push({
          id: "item-" + i + "-" + slugify(line),
          title: line,
          description: "",
          keys: [],
          command: line,
          tags: []
        });
        continue;
      }

      if (line.startsWith("# ")) {
        sourceTitle = sourceCfg.title || line.substring(2).trim();
        continue;
      }

      if (line.startsWith("## ")) {
        if (currentSection) {
          currentSection.description = introBuffer.join(" ").trim();
          sections.push(currentSection);
        }
        currentSection = {
          id: slugify(line.substring(3).trim()),
          title: line.substring(3).trim(),
          description: "",
          items: []
        };
        introBuffer = [];
        continue;
      }

      var item = parseMarkdownLine(line, i);
      ensureSection();
      if (item) {
        currentSection.items.push(item);
      } else if (!line.startsWith("```")) {
        introBuffer.push(line.replace(/^`+|`+$/g, ""));
      }
    }

    if (currentSection) {
      currentSection.description = introBuffer.join(" ").trim();
      sections.push(currentSection);
    }

    return {
      id: sourceCfg.id,
      title: sourceTitle,
      icon: sourceCfg.icon || "description",
      sourceType: sourceCfg.type,
      enabled: sourceCfg.enabled !== false,
      sections: sections.filter(section => section.items.length > 0 || section.description.length > 0)
    };
  }

  function parseNiriTitle(line) {
    var match = line.match(/hotkey-overlay-title="([^"]+)"/);
    return match ? match[1] : "";
  }

  function parseNiriKeys(line) {
    var trimmed = String(line || "").trim();
    var braceIndex = trimmed.indexOf(" {");
    if (braceIndex < 0) return "";

    var prefix = trimmed.substring(0, braceIndex)
      .replace(/\s+hotkey-overlay-title="[^"]+"/g, "")
      .replace(/\s+repeat=false/g, "")
      .replace(/\s+allow-inhibiting=false/g, "")
      .replace(/\s+allow-when-locked=true/g, "")
      .replace(/\s+cooldown-ms=\d+/g, "")
      .trim();

    return prefix;
  }

  function parseNiriAction(line) {
    var match = String(line || "").match(/\{\s*([^;{]+)[;}]?/);
    return match ? match[1].trim() : "";
  }

  function normalizeGeneratedBindings(sourceCfg, content) {
    var lines = String(content || "").split(/\r?\n/);
    var sections = [];
    var currentSection = null;

    function pushCurrent() {
      if (currentSection && currentSection.items.length > 0) {
        sections.push(currentSection);
      }
    }

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i].trim();
      if (!line.length) continue;

      var sectionMatch = line.match(/^\/\/\s+#"(.+)"$/);
      if (sectionMatch) {
        pushCurrent();
        currentSection = {
          id: slugify(sectionMatch[1]),
          title: sectionMatch[1],
          description: "",
          items: []
        };
        continue;
      }

      if (line.indexOf("{") >= 0 && line.indexOf("}") >= 0 && !line.startsWith("//")) {
        if (!currentSection) {
          currentSection = {
            id: "bindings",
            title: "Bindings",
            description: "",
            items: []
          };
        }

        var title = parseNiriTitle(line);
        var action = parseNiriAction(line);
        var itemTitle = title || action || "Binding";
        currentSection.items.push({
          id: "bind-" + i + "-" + slugify(itemTitle),
          title: itemTitle,
          description: action,
          keys: [parseNiriKeys(line)],
          command: "",
          tags: []
        });
      }
    }

    pushCurrent();

    return {
      id: sourceCfg.id,
      title: sourceCfg.title || sourceCfg.id,
      icon: sourceCfg.icon || "dashboard",
      sourceType: sourceCfg.type,
      enabled: sourceCfg.enabled !== false,
      sections: sections
    };
  }

  function selectDefaultSourceIfMissing() {
    if (!sourcesData.length) {
      selectedSourceId = "";
      return;
    }

    for (var i = 0; i < sourcesData.length; i++) {
      if (sourcesData[i].id === selectedSourceId) return;
    }

    selectedSourceId = cfg.defaultSourceId || defaults.defaultSourceId || sourcesData[0].id;
  }

  function loadAllSources() {
    var configured = getConfiguredSources();
    var results = [];

    for (var i = 0; i < configured.length; i++) {
      var src = configured[i];
      if (src.enabled === false) continue;

      if (src.type === "markdown") {
        results.push({ source: src, mode: "markdown" });
      } else if (src.type === "generated-keybinds" && src.generator === "niri") {
        results.push({ source: src, mode: "niri" });
      }
    }

    pendingSources = results;
    parsedSources = [];
    processNextSource();
  }

  function refresh() {
    loadAllSources();
  }

  function processNextSource() {
    if (pendingSources.length === 0) {
      sourcesData = parsedSources;
      selectDefaultSourceIfMissing();
      isLoading = false;
      setStatus("Loaded " + parsedSources.length + " source(s)", "");
      return;
    }

    var next = pendingSources.shift();
    currentSource = next;
    sourceReader.command = ["cat", next.source.path];
    sourceReader.running = true;
  }

  property var pendingSources: []
  property var parsedSources: []
  property var currentSource: null
  property string currentContent: ""

  Process {
    id: sourceReader
    running: false

    stdout: SplitParser {
      onRead: data => {
        currentContent += data + "\n";
      }
    }

    onStarted: {
      currentContent = "";
      isLoading = true;
      setStatus("Loading " + (currentSource?.source?.title || "source") + "...", "");
    }

    onExited: exitCode => {
      if (exitCode === 0 && currentSource) {
        try {
          if (currentSource.mode === "markdown") {
            parsedSources.push(normalizeMarkdownContent(currentSource.source, currentContent));
          } else if (currentSource.mode === "niri") {
            parsedSources.push(normalizeGeneratedBindings(currentSource.source, currentContent));
          }
        } catch (e) {
          setStatus("Load failed", String(e));
        }
      } else if (currentSource) {
        setStatus("Load failed", "Cannot read " + currentSource.source.path);
      }

      processNextSource();
    }
  }

  Component.onCompleted: refresh()
  onPluginApiChanged: if (pluginApi) refresh()
}
