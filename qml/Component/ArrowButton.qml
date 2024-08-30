import QtQuick
import QtQuick.Controls

Rectangle {
    id: arrowButton
    height: 40
    radius: 5

    property color baseColor : "#F3F3F3"
    property color hoverColor: "#DCDCDC"
    property color selectedColor: "#ECECEC"
    color: baseColor

    property bool isSelected: false


    signal clicked()
    Image {
        id: buttonImage
        anchors.centerIn: parent
        source : "qrc:/icons/other/arrow-right-arrow-left.svg"
        sourceSize.height: arrowButton.height * 0.6
        sourceSize.width: arrowButton.height * 0.5

        transform: Rotation{
            id: trans
            origin.x: arrowButton.width / 16
            origin.y: arrowButton.height / 2

            axis.x: 0
            axis.y: 1
            axis.z: 0

            angle: 180
        }

        ParallelAnimation {
            id: checkAnimation
            PropertyAnimation {
                target: trans
                property:  "angle"
                from: 0
                to: 180
                duration: 200
            }
        }

        ParallelAnimation {
            id: uncheckAnimation
            PropertyAnimation {
                target: trans
                property:  "angle"
                from: 180
                to: 0
                duration: 200
            }
        }

        Component.onCompleted:{
            uncheckAnimation.start()
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
                checkAnimation.start()
            }
            else {
                uncheckAnimation.start()
            }
            // mouseArea.anchors.fill = parent
        }

        onEntered: {
            arrowButton.color = arrowButton.hoverColor
        }
        onExited: {
            arrowButton.color = arrowButton.isSelected ? arrowButton.selectedColor : arrowButton.baseColor
        }
    }

}