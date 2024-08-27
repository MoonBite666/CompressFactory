import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: navButton
    width: 100
    height: 40

    property color baseColor : "transparent"
    property color hoverColor: Qt.lighter(baseColor, 1.5)
    property color selectedColor: Qt.darker(baseColor, 1.5)


    property url imageSourceUnchecked : ""
    property url imageSourceChecked : ""

    property alias text: t.text

    property bool isSelected: false
    color: isSelected ? selectedColor : baseColor


    signal clicked()

    // 图片
    RowLayout{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 5
        spacing: 10
        Image {
            id: buttonImage
            Layout.alignment: Qt.AlignLeft
            source: navButton.imageSourceUnchecked
            // anchors.leftMargin: 5
            sourceSize.width: parent.parent.width * 0.2
            sourceSize.height: parent.parent.height * 0.6
        }
        Text {
            id: t
        }

    }


    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            navButton.clicked()
            navButton.color = navButton.selectedColor
            buttonImage.source = navButton.imageSourceChecked
            navButton.isSelected = true
        }

        onEntered: {
            // buttonImage.source = navButton.imageSourceChecked
            navButton.color = navButton.hoverColor // 改变背景颜色
        }
        onExited: {
            // buttonImage.source = navButton.imageSourceUnchecked
            navButton.color = navButton.isSelected ? navButton.selectedColor : navButton.baseColor
        }
    }

    function toggleSelection(){
        color = isSelected ? selectedColor : baseColor
        buttonImage.source = isSelected? navButton.imageSourceChecked : navButton.imageSourceUnchecked
    }

}