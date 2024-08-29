import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: navButton
    width: parent.width
    height: 40
    radius: 5
    Behavior on width {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
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

    // 图片
    RowLayout {
        id: layout
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 5

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        transitions: Transition {
            NumberAnimation {
                properties: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


        Rectangle {
            id: indicator

            color: "#6E9FF6"
            Layout.alignment: Qt.AlignVCenter
            width: 5
            height: navButton.height * 0.6
            radius: 5

        }
        Image {
            id: buttonImage
            // Layout.alignment: Qt.AlignLeft
            // anchors.leftMargin: navButton.isSelected ? 0 : 10
            source: navButton.imageSourceUnchecked
            sourceSize.height: navButton.height * 0.6
            sourceSize.width: navButton.height * 0.5
        }
        Text {
            id: t
            Layout.alignment: Qt.AlignVCenter
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
    Component.onCompleted: {

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
            buttonImage.anchors.leftMargin = 0
        }
        else{
            if(isSelected) {
                shrinkAnimation.start()
                indicator.visible = false
            }
            isSelected = false
            navButton.color = navButton.baseColor
            buttonImage.source = navButton.imageSourceUnchecked
            buttonImage.anchors.leftMargin = 10
        }
    }

    function acrossWidth(state){
        console.log("in " + state + " !")
        if(state === "expanded") {
            navButton.width = 150
            layout.width = 150
            t.visible = true
            if(!isSelected){
                buttonImage.x -= 20
                t.x -= 20
            }
        }
        else {
            navButton.width = 60
            layout.width = 60
            t.visible = false
        }
    }

}