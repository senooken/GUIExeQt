import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import myclass 1.0

//

ApplicationWindow {
    id: applicationWindow
    visible: true
    title: qsTr("GUIExec")

    FileDialog {
        id: fd
    }

    function loadTab() {
        tv.addTab()
    }

    Action {
        id: quitAction
        text: "&Quit"
        shortcut: StandardKey.Quit
        onTriggered: Qt.quit()
    }

    Action {
        id: importAction
        text: "&Import"
    }

    Action {
        id: exportAction
        text: "&Export"
    }

    menuBar: MenuBar {
        id: menuBar
        Menu {
            id: file
            title: qsTr("&File")
            MenuItem { action: importAction }
            MenuItem { action: exportAction }
            MenuItem { action: quitAction }
        }
        Menu {
            id: help
            title: qsTr("&Help")
            MenuItem {
                text: "&About"
            }
        }
    }

    FontMetrics {
        id: fm
    }

    MyClass {
        id: myClass
    }

    TabView {
        id: tv
        anchors.fill: parent
//        anchors.margins: 20
        Layout.minimumWidth: 260
        Layout.minimumHeight: 260
        Layout.preferredWidth: 420
        Layout.preferredHeight: 440

        Tab {
            id: tab1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            title: "Default"
            ScrollView {
                id: sv
                anchors.fill: parent
//                anchors.horizontalCenter: parent.horizontalCenter

                GridLayout {
                    id: grid
//                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
//                    anchors.fill: parent

                    anchors.leftMargin: grid.rowSpacing
                    anchors.rightMargin: grid.rowSpacing
                    anchors.topMargin: grid.columnSpacing

                    Layout.fillWidth: true
                    columns: sv.width < sv.height ? 1 : 2

                    Settings {
                        property alias exe: exe.text
                        property alias stdout: stdout.text
                        property alias stdin: stdin.text
                    }

                    Button {
                        text: "Run"
                        onClicked: {
                            command.text = exe.text + " " +arg1.text + " " + arg2.text
                            var exec = myClass.exec(command.text)
                            stdout.text = exec.stdout
                            stderr.text = exec.stderr
                            exit.text = exec.exit
                            print(exe.text)
                            print("stdout:" + stdout.text)
                            print("stderr:" + stderr.text)
                        }
                    }
                    Button {
                        text: "Stop"
                        onClicked: print("Stop")
                    }

                    Button {
                        id: exeDialog
                        text: "EXE"
                        onClicked: {fd.open(); exe.text = fd.fileUrl}
                    }

                    TextField {
                        id: exe
                        Layout.fillWidth: true
                    }

                    Text {
                        text: "COMMAND"
                    }
                    TextArea {
                        id: command
                        Layout.fillWidth: true
                        implicitHeight: fm.height*2
                    }

                    Text {
                        text: "EXIT CODE"
                    }
                    TextArea {
                        id: exit
                        Layout.fillWidth: true
                        implicitHeight: fm.height*2

                    }
                    Text {
                        text: "STDERR"
                    }
                    TextArea {
                        id: stderr
                        Layout.fillWidth: true
                        implicitHeight: fm.height*2

                    }
                    Text {
                        text: "STDOUT"
                    }
                    TextArea {
                        id: stdout
                        Layout.fillWidth: true
                    }

                    Text {
                        text: "STDIN"
                    }
                    TextArea {
                        id: stdin
                        Layout.fillWidth: true
                        implicitHeight: fm.height*2
                    }

                    Text {
                        text: "ARG 1"
                    }
                    TextField {
                        id: arg1
                        Layout.fillWidth: true
                    }
                    Text {
                        text: "ARG 2"
                    }
                    TextField {
                        id: arg2
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        print(fm.height + ", " + fm.xHeight)
    }

}
