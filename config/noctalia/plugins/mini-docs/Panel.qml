import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

Item {
  id: root

  property var pluginApi: null
  property var cfg: pluginApi?.pluginSettings || ({})
  property var main: pluginApi?.mainInstance
  property var sources: main?.sourcesData || []
  property string searchText: ""
  property string selectedSourceId: main?.selectedSourceId || ""
  property var selectedSource: null

  readonly property var geometryPlaceholder: panelContainer
  readonly property bool allowAttach: false
  readonly property bool panelAnchorHorizontalCenter: true
  readonly property bool panelAnchorVerticalCenter: true
  property real contentPreferredWidth: cfg.panelWidth || 1200
  property real contentPreferredHeight: 760

  anchors.fill: parent

  function sourceMatches(item) {
    if (!searchText.length) return true;
    var q = searchText.toLowerCase();
    return String(item.title || "").toLowerCase().indexOf(q) >= 0
      || String(item.description || "").toLowerCase().indexOf(q) >= 0
      || String(item.command || "").toLowerCase().indexOf(q) >= 0
      || (item.keys || []).join(" ").toLowerCase().indexOf(q) >= 0
      || (item.tags || []).join(" ").toLowerCase().indexOf(q) >= 0;
  }

  function visibleSections() {
    if (!selectedSource || !selectedSource.sections) return [];
    var filtered = [];
    for (var i = 0; i < selectedSource.sections.length; i++) {
      var section = selectedSource.sections[i];
      var items = [];
      for (var j = 0; j < section.items.length; j++) {
        if (sourceMatches(section.items[j])) items.push(section.items[j]);
      }
      if (!searchText.length || items.length > 0 || String(section.title || "").toLowerCase().indexOf(searchText.toLowerCase()) >= 0) {
        filtered.push({
          id: section.id,
          title: section.title,
          description: section.description,
          items: searchText.length ? items : section.items
        });
      }
    }
    return filtered;
  }

  onSourcesChanged: {
    var next = null;
    for (var i = 0; i < sources.length; i++) {
      if (sources[i].id === selectedSourceId) {
        next = sources[i];
        break;
      }
    }
    selectedSource = next || (sources.length ? sources[0] : null);
    if (selectedSource && selectedSource.id !== selectedSourceId) {
      selectedSourceId = selectedSource.id;
    }
  }

  Rectangle {
    id: panelContainer
    anchors.fill: parent
    color: Color.mSurface
    radius: Style.radiusL
    clip: true

    Rectangle {
      id: header
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: 48
      color: Color.mSurfaceVariant

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Style.marginM
        anchors.rightMargin: Style.marginM
        spacing: Style.marginS

        NIcon {
          icon: "description"
          pointSize: Style.fontSizeM
          color: Color.mPrimary
        }

        NText {
          text: "Mini Docs"
          font.pointSize: Style.fontSizeM
          font.weight: Font.Bold
          color: Color.mPrimary
        }

        Item { Layout.fillWidth: true }

        NIconButton {
          icon: "refresh"
          onClicked: pluginApi?.mainInstance?.refresh()
        }

        NIconButton {
          icon: "settings"
          onClicked: {
            var screen = pluginApi?.panelOpenScreen;
            if (screen && pluginApi?.manifest) {
              BarService.openPluginSettings(screen, pluginApi.manifest);
            }
          }
        }
      }
    }

    RowLayout {
      anchors.top: header.bottom
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      spacing: 0

      Rectangle {
        Layout.preferredWidth: 240
        Layout.fillHeight: true
        color: Color.mSurfaceVariant

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: Style.marginM
          spacing: Style.marginS

          NText {
            text: "Sources"
            font.weight: Style.fontWeightBold
            color: Color.mOnSurface
          }

          Repeater {
            model: sources

            Rectangle {
              Layout.fillWidth: true
              implicitHeight: 42
              radius: Style.radiusM
              color: selectedSourceId === modelData.id ? Color.mPrimary : Color.mSurface

              MouseArea {
                anchors.fill: parent
                onClicked: {
                  selectedSourceId = modelData.id;
                  selectedSource = modelData;
                  searchText = "";
                }
              }

              RowLayout {
                anchors.fill: parent
                anchors.margins: Style.marginM
                spacing: Style.marginS

                NIcon {
                  icon: modelData.icon || "description"
                  color: selectedSourceId === modelData.id ? Color.mOnPrimary : Color.mOnSurface
                }

                NText {
                  Layout.fillWidth: true
                  text: modelData.title
                  color: selectedSourceId === modelData.id ? Color.mOnPrimary : Color.mOnSurface
                  wrapMode: Text.NoWrap
                  elide: Text.ElideRight
                }
              }
            }
          }
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: Color.mSurface

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: Style.marginM
          spacing: Style.marginM

          NText {
            Layout.fillWidth: true
            text: selectedSource ? selectedSource.title : "No sources"
            pointSize: Style.fontSizeXL
            font.weight: Style.fontWeightBold
            color: Color.mOnSurface
          }

          NTextInput {
            Layout.fillWidth: true
            Layout.preferredHeight: Style.baseWidgetSize
            text: searchText
            placeholderText: cfg.searchPlaceholder || "Search current tool..."
            onTextChanged: searchText = text
          }

          NText {
            Layout.fillWidth: true
            visible: !selectedSource && !main?.isLoading
            text: cfg.lastError || "No sources loaded."
            color: Color.mOnSurfaceVariant
            wrapMode: Text.WordWrap
          }

          NText {
            Layout.fillWidth: true
            visible: main?.isLoading
            text: cfg.lastStatus || "Loading..."
            color: Color.mOnSurfaceVariant
          }

          NScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            visible: !!selectedSource

            ColumnLayout {
              width: parent.width
              spacing: Style.marginM

              Repeater {
                model: root.visibleSections()

                ColumnLayout {
                  Layout.fillWidth: true
                  spacing: Style.marginS

                  NText {
                    Layout.fillWidth: true
                    text: modelData.title
                    pointSize: Style.fontSizeL
                    font.weight: Style.fontWeightBold
                    color: Color.mPrimary
                  }

                  NText {
                    Layout.fillWidth: true
                    visible: !!modelData.description
                    text: modelData.description || ""
                    color: Color.mOnSurfaceVariant
                    wrapMode: Text.WordWrap
                  }

                  Repeater {
                    model: modelData.items

                    Rectangle {
                      Layout.fillWidth: true
                      implicitHeight: itemColumn.implicitHeight + Style.marginM * 2
                      radius: Style.radiusM
                      color: Color.mSurfaceVariant

                      ColumnLayout {
                        id: itemColumn
                        anchors.fill: parent
                        anchors.margins: Style.marginM
                        spacing: Style.marginXS

                        NText {
                          Layout.fillWidth: true
                          visible: (modelData.keys || []).length > 0
                          text: (modelData.keys || []).join(" · ")
                          color: Color.mPrimary
                          font.weight: Style.fontWeightBold
                          wrapMode: Text.WordWrap
                        }

                        NText {
                          Layout.fillWidth: true
                          visible: !!modelData.command
                          text: modelData.command || ""
                          color: Color.mPrimary
                          font.weight: Style.fontWeightBold
                          wrapMode: Text.WordWrap
                        }

                        NText {
                          Layout.fillWidth: true
                          text: modelData.title
                          color: Color.mOnSurface
                          font.weight: Style.fontWeightBold
                          wrapMode: Text.WordWrap
                        }

                        NText {
                          Layout.fillWidth: true
                          visible: !!modelData.description && modelData.description !== modelData.title
                          text: modelData.description || ""
                          color: Color.mOnSurfaceVariant
                          wrapMode: Text.WordWrap
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
