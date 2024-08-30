import QtQuick
import QtQuick.Controls

Rectangle {
    id: arrowButton
    width: parent.width
    height: 40
    radius: 5

    color: "#F3F3F3"

    property url imageSourceUnchecked : "qrc:/icons/unchecked/arrow-right.svg"
    property url imageSourceChecked : "qrc:/icons/checked/arrow-right.svg"

    property bool isSelected: false


    signal clicked()
    Image {
        id: buttonImage
        anchors.centerIn: parent
        source : arrowButton.imageSourceUnchecked
        sourceSize.height: arrowButton.height * 0.6
        sourceSize.width: arrowButton.height * 0.5

        transform: Rotation {
            id: rotation
            origin.x: buttonImage.width / 2
            origin.y: buttonImage.height / 2
            angle: 0
        }

        ParallelAnimation {
            id: checkAnimation
            PropertyAnimation {
                target: rotation
                property: "angle"
                from: 0
                to: 180
                duration: 200
            }

            ScriptAction {
                script: {
                    buttonImage.anchors.centerIn = arrowButton
                }
            }
        }

        ParallelAnimation {
            id: uncheckAnimation
            PropertyAnimation {
                target: rotation
                property: "angle"
                from: 180
                to: 360
                duration: 200
            }

            ScriptAction {
                script: {
                    buttonImage.anchors.right = arrowButton.right
                    buttonImage.anchors.rightMargin = 10
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
            arrowButton.clicked()
            arrowButton.isSelected = !arrowButton.isSelected
            if(arrowButton.isSelected){
                buttonImage.source = arrowButton.imageSourceChecked
                checkAnimation.start()
            }
            else {
                buttonImage.source = arrowButton.imageSourceUnchecked
                uncheckAnimation.start()
            }

        }

        onEntered: {
            buttonImage.source = arrowButton.imageSourceChecked
        }
        onExited: {
            buttonImage.source = arrowButton.imageSourceUnchecked
        }
    }

}