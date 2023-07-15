import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 
import QtQuick.Dialogs

ApplicationWindow {
	id: mainwin
    visible: true
    width: 700
    height: 500
    visibility: "Maximized"
    title: "freefang-qt"
    property string version: "0.1.1"
	property string gameid: "Game ID here"
	property string gameserver: "127.0.0.1:9999"
	property int playercap: 5
	color: "#202020"

	MessageDialog{
		id: mainmenumd
		text: "Are you sure you want to go back to the main menu?"
    	buttons: MessageDialog.Ok | MessageDialog.Cancel	
		onAccepted: {
			stack.pop(null);
			game_loop.quitgame();
		}
	}

    Shortcut {
        sequence: "Esc"
        onActivated: {
			mainmenumd.open();
		}
    }
    
	Connections {
			target: game_creation_ui

			function onGameidupdated(msg) {
				gameid = msg;
			}
			function onGameserverupdated(msg) {
				gameserver = msg;
			}
	}


    StackView {

        id: stack
        initialItem: mainmenu
        anchors.fill: parent
    }
    
    Component {
        id: mainmenu
        
			ColumnLayout{
				Rectangle { 
					Layout.alignment : Qt.AlignHCenter 
					Layout.topMargin: 75
					color: 'teal'
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					Text {
						anchors.centerIn: parent
						font.pointSize: 24
						text: "FreeFang-QT"
					}
				}
				Button {
					text: "<font color=\"white\">Join Game</font>"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						color: "black"
						border.width: 1
					}
					onClicked: {
						stack.push(Qt.createComponent("Join_Game.qml").createObject())
					}

				}
				Button {
					text: "<font color=\"white\">Create Game</font>"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						color: "black"

						border.width: 1
					}
					onClicked: {
						stack.push(Qt.createComponent("Create_Game.qml").createObject())
					}
				}

				Button {
					text: "<font color=\"white\">Settings</font>"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						color: "black"

						border.width: 1
					}
				}

				Item {
					// Spacer
					Layout.fillHeight: true
				}

			
        }


        

}
}
    

