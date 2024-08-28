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

    property int refIndex: 0

    signal clicked()

    // 图片
    RowLayout{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 15
        spacing: 5

        Rectangle {
            id: indicator
            color: "cyan"
            Layout.alignment: Qt.AlignVCenter
            width: 6
            height: navButton.height * 0.6
            radius: 5

            PropertyAnimation {
                id: stretchAnimation
                running: false
                target: indicator
                property: "scale"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }
            PropertyAnimation {
                id: shrinkAnimation
                running: false
                target: indicator
                property: "scale"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        Image {
            id: buttonImage
            Layout.alignment: Qt.AlignLeft
            source: navButton.imageSourceUnchecked
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
        }

        onEntered: {
            navButton.color = navButton.hoverColor // 改变背景颜色
        }
        onExited: {
            navButton.color = navButton.isSelected ? navButton.selectedColor : navButton.baseColor
        }
    }

    function toggleSelection(index){
        if(index === refIndex){
            if(!isSelected) stretchAnimation.start()
            isSelected = true;
            navButton.color = navButton.selectedColor
            buttonImage.source = navButton.imageSourceChecked
        }
        else{
            if(isSelected) shrinkAnimation.start()
            isSelected = false
            navButton.color = navButton.baseColor
            buttonImage.source = navButton.imageSourceUnchecked
            indicator.scale = 0
        }
    }

}