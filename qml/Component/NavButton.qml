import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: navButton
    width: 100
    height: 40

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
    RowLayout{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 5

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
            Layout.alignment: Qt.AlignLeft
            source: navButton.imageSourceUnchecked
            sourceSize.width: parent.parent.width * 0.2
            sourceSize.height: parent.parent.height * 0.6
        }
        Text {
            id: t
        }

        SequentialAnimation{
            id: stretchAnimation
            running: false
            ScriptAction{
                script: {
                    if(!indicator.visible && !stretchAnimation.running){
                        indicator.visible = true
                        console.log("Stretch " + buttonImage.x + " sub 10")
                        buttonImage.x -= 10
                        t.x -= 10
                        console.log("Now " + buttonImage.x)
                    }
                }
            }
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
                PropertyAnimation {
                    target: buttonImage
                    property: "x"
                    from: buttonImage.x
                    to: buttonImage.x + 10
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    target: t
                    property: "x"
                    from: t.x
                    to: t.x + 10
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
                PropertyAnimation {
                    target: buttonImage
                    property: "x"
                    from: buttonImage.x
                    to: buttonImage.x - 10
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    target: t
                    property: "x"
                    from: t.x
                    to: t.x - 10
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            ScriptAction{
                script: {
                    if(indicator.visible && !shrinkAnimation.running) {
                        indicator.visible = false
                        console.log("Stretch " + buttonImage.x + " add 10")
                        buttonImage.x += 10
                        t.x += 10
                        console.log("Now " + buttonImage.x)
                    }
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
                stretchAnimation.start()
            }
            isSelected = true;
            navButton.color = navButton.selectedColor
            buttonImage.source = navButton.imageSourceChecked
        }
        else{
            if(isSelected) {
                shrinkAnimation.start()
            }
            isSelected = false
            navButton.color = navButton.baseColor
            buttonImage.source = navButton.imageSourceUnchecked
        }
    }

}