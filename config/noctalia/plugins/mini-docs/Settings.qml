import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Widgets

Item {
  id: rootItem
  implicitWidth: 640
  implicitHeight: root.implicitHeight
  width: Math.max(implicitWidth, parent ? parent.width : 0)

  property var pluginApi: null

  ColumnLayout {
    id: root
    implicitWidth: 640
    width: parent.width
    spacing: Style.marginM

    property var cfg: rootItem.pluginApi?.pluginSettings || ({})
    property var defaults: rootItem.pluginApi?.manifest?.metadata?.defaultSettings || ({})
    property int panelWidth: cfg.panelWidth ?? defaults.panelWidth ?? 1200
    property string defaultSourceId: cfg.defaultSourceId || defaults.defaultSourceId || "yazi"
    property var sources: cfg.sources || defaults.sources || []

    NText {
      Layout.fillWidth: true
      text: "Mini Docs Settings"
      pointSize: Style.fontSizeXXL
      font.weight: Style.fontWeightBold
      color: Color.mOnSurface
    }

    NText {
      Layout.fillWidth: true
      text: "V1 keeps source definitions read-only. Adjust panel basics here, then refresh the plugin."
      color: Color.mOnSurfaceVariant
      wrapMode: Text.WordWrap
    }

    NBox {
      Layout.fillWidth: true
      Layout.preferredHeight: basicsColumn.implicitHeight + Style.marginM * 2
      color: Color.mSurfaceVariant

      ColumnLayout {
        id: basicsColumn
        anchors.fill: parent
        anchors.margins: Style.marginM
        spacing: Style.marginS

        NText {
          text: "Display"
          pointSize: Style.fontSizeL
          font.weight: Style.fontWeightBold
          color: Color.mOnSurface
        }

        RowLayout {
          Layout.fillWidth: true
          spacing: Style.marginM

          NText {
            text: "Panel width"
            Layout.preferredWidth: 140
            color: Color.mOnSurface
          }

          NTextInput {
            Layout.preferredWidth: 120
            Layout.preferredHeight: Style.baseWidgetSize
            text: root.panelWidth.toString()
            onTextChanged: {
              var val = parseInt(text);
              if (!isNaN(val) && val >= 700 && val <= 1800) {
                rootItem.pluginApi.pluginSettings.panelWidth = val;
              }
            }
          }
        }

        RowLayout {
          Layout.fillWidth: true
          spacing: Style.marginM

          NText {
            text: "Default source"
            Layout.preferredWidth: 140
            color: Color.mOnSurface
          }

          NComboBox {
            Layout.preferredWidth: 220
            Layout.preferredHeight: Style.baseWidgetSize
            model: ListModel {
              id: sourceModel
              Component.onCompleted: {
                clear();
                for (var i = 0; i < root.sources.length; i++) {
                  if (root.sources[i].enabled !== false) {
                    append({ name: root.sources[i].title || root.sources[i].id, key: root.sources[i].id });
                  }
                }
              }
            }
            currentKey: root.defaultSourceId
            onSelected: key => rootItem.pluginApi.pluginSettings.defaultSourceId = key
          }
        }
      }
    }

    NBox {
      Layout.fillWidth: true
      Layout.preferredHeight: sourceColumn.implicitHeight + Style.marginM * 2
      color: Color.mSurfaceVariant

      ColumnLayout {
        id: sourceColumn
        anchors.fill: parent
        anchors.margins: Style.marginM
        spacing: Style.marginS

        NText {
          text: "Curated sources"
          pointSize: Style.fontSizeL
          font.weight: Style.fontWeightBold
          color: Color.mOnSurface
        }

        Repeater {
          model: root.sources

          Rectangle {
            Layout.fillWidth: true
            implicitHeight: sourceText.implicitHeight + Style.marginM * 2
            color: Color.mSurface
            radius: Style.radiusM

            NText {
              id: sourceText
              anchors.fill: parent
              anchors.margins: Style.marginM
              text: (modelData.title || modelData.id) + " · " + modelData.type + "\n" + (modelData.path || "")
              color: Color.mOnSurface
              wrapMode: Text.WordWrap
            }
          }
        }

        NText {
          Layout.fillWidth: true
          text: "Source editing is intentionally out of scope for v1."
          color: Color.mOnSurfaceVariant
          wrapMode: Text.WordWrap
        }
      }
    }

    NButton {
      text: "Refresh plugin data"
      onClicked: rootItem.pluginApi?.mainInstance?.refresh()
    }
  }
}
