import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: navButton
    width: 100
    height: 40

    property color baseColor : "transparent"
    property color lighterColor: Qt.lighter(baseColor, 1.5)
    property color darkerColor: Qt.darker(baseColor, 1.5)
    color: baseColor

    property url imageSourceUnchecked : ""
    property url imageSourceChecked : ""

    property alias text: t.text



    // 图片
    RowLayout{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 5
        spacing: 10
        Image {
            id: buttonImage
            anchors.left: parent.left
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
        onClicked: {
            console.log("Audio Clicked")
        }

        // 鼠标悬停效果
        onEntered: {
            buttonImage.source = navButton.imageSourceChecked
            navButton.color = navButton.darkerColor // 改变背景颜色
        }
        onExited: {
            buttonImage.source = navButton.imageSourceUnchecked
            navButton.color = navButton.baseColor // 恢复背景颜色
        }
    }
}