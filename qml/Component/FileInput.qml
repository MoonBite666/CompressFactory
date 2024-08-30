import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform


Item {
    property string defaultHint

    RowLayout {
        id: headLayout
        height: 30
        spacing: 5
        Rectangle {
            height: parent.height
            width: 300
            border.width: 2
            border.color: "black"
            Layout.alignment: Qt.LeftAlignment | Qt.AlignVCenter
            color: "transparent"
            TextInput {
                id: inputBoxInput
                text: folderDialog.folder.toString().replace("file:///", "")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 1
                color: "#707070"
                font.pixelSize: 16
                activeFocusOnTab: true
                selectByMouse: true //是否可以选择文本
                selectedTextColor: "white" //设置选择文本的字体颜色
                selectionColor: "#4A6DBC" //设置选择框的颜色
            }
        }

        Rectangle {
            Layout.alignment: Qt.LeftAlignment | Qt.AlignVCenter
            height: parent.height
            width: 25
            color: "white"
            Text{
                anchors.centerIn: parent
                text: "..."
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    folderDialog.open()
                }
            }
        }
        FolderDialog {
            id: folderDialog
            folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0] //默认打开Pictures文件夹
        }
    }
}