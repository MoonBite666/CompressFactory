import QtQuick
import QtQuick.Controls

Rectangle {
    id: arrowButton
    width: parent.width
    height: 40
    radius: 5

    property color baseColor : "#F3F3F3"
    property color hoverColor: "#DCDCDC"
    property color selectedColor: "#DCDCDC"


    signal clicked()
    Image {
        id: buttonImage
        anchors.centerIn: parent
        source: "qrc:/icons/other/arrow-right.svg"
        sourceSize.height: arrowButton.height * 0.6
        sourceSize.width: arrowButton.height * 0.5
    }

    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            arrowButton.clicked()
        }

        onEntered: {
            arrowButton.color = arrowButton.hoverColor // 改变背景颜色
        }
        onExited: {
            arrowButton.color = arrowButton.baseColor
        }
    }

}