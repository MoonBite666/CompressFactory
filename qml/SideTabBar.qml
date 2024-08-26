import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: sideTabBar
    width: 50 // 初始宽度，显示一小部分
    height: parent.height - 32
    color: "gray"

    // 菜单项
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Button {
            text: qsTr("菜单项 1")
            onClicked: {
                console.log("菜单项 1 被点击")
            }
        }

        Button {
            text: qsTr("菜单项 2")
            onClicked: {
                console.log("菜单项 2 被点击")
            }
        }

        Button {
            text: qsTr("菜单项 3")
            onClicked: {
                console.log("菜单项 3 被点击")
            }
        }
    }

    // 状态和动画
    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                target: sideTabBar
                width: 50
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: sideTabBar
                width: 200
            }
        }
    ]

    transitions: [
        Transition {
            from: "collapsed"
            to: "expanded"
            reversible: true
            NumberAnimation {
                target: sideTabBar
                property: "width"
                duration: 200
            }
        }
    ]
}