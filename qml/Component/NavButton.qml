import QtQuick
import QtQuick.Controls

Rectangle {
    id: navButton
    width: parent.width
    height: 40
    radius: 5
    Behavior on width {
        NumberAnimation {
            duration: 1
            // easing.type: Easing.InOutQuad
        }
    }

    property color baseColor : "#F3F3F3"
    property color hoverColor: "#DCDCDC"
    property color selectedColor: "#DCDCDC"


    property url imageSourceUnchecked : ""
    property url imageSourceChecked : ""

    property alias text: t.text

    property bool isSelected: true
    color: isSelected ? selectedColor : baseColor

    property int refIndex: 0

    signal clicked()


    Item {
        id: layout
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10


        Rectangle {
            id: indicator

            color: "#6E9FF6"
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            width: 5
            height: navButton.height * 0.6
            radius: 5


        }
        Image {
            id: buttonImage
            anchors.left : indicator.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            source: navButton.imageSourceUnchecked
            sourceSize.height: navButton.height * 0.6
            sourceSize.width: navButton.height * 0.5
        }
        Text {
            id: t
            anchors.left : buttonImage.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 30
            font.pixelSize: 18
            Component.onCompleted: {
                t.font.family = getFontFamily(text)
            }
        }

        SequentialAnimation{
            id: stretchAnimation
            running: false
            ParallelAnimation{
                PropertyAnimation {
                    target: indicator
                    property: "scale"
                    from: 0
                    to: 1
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    target: indicator
                    property: "color"
                    from: "transparent"
                    to: "#6E9FF6"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
        SequentialAnimation{
            id: shrinkAnimation
            running: false
            ParallelAnimation{
                PropertyAnimation {
                    target: indicator
                    property: "scale"
                    from: 1
                    to: 0
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    target: indicator
                    property: "color"
                    from: "#6E9FF6"
                    to: "transparent"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
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
            if(!isSelected) {
                indicator.visible = true
                stretchAnimation.start()
            }
            isSelected = true;
            navButton.color = navButton.selectedColor
            buttonImage.source = navButton.imageSourceChecked
            buttonImage.anchors.leftMargin = 5
            t.anchors.leftMargin = 25
        }
        else{
            if(isSelected) {
                shrinkAnimation.start()
                indicator.visible = false
            }
            isSelected = false
            navButton.color = navButton.baseColor
            buttonImage.source = navButton.imageSourceUnchecked
            buttonImage.anchors.leftMargin = 0
            t.anchors.leftMargin = 30
        }
    }

    function acrossWidth(state){
        if(state === "expanded") {
            navButton.width = 150
            layout.width = 150
            t.visible = true
        }
        else {
            navButton.width = 60
            layout.width = 60
            t.visible = false
        }
    }

    function getFontFamily(text){
        var chineseRegex = /[\u4e00-\u9fa5]/;
        if (chineseRegex.test(text)) {
            return "SimHei";
        } else {
            return "Arial";
        }
    }
}