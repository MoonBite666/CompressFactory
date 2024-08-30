import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform

import "Component"

Rectangle {
    anchors{
        top: titleBar.bottom
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    color: "lightgray"
    FileInput{
        anchors{
            left: parent.left
            top: parent.top
            leftMargin: 10
            topMargin: 10
        }
    }



}