import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 


ApplicationWindow {
    visible: true
    width: 700
    height: 500
    visibility: "Maximized"
    title: "freefang-qt"
    property string version: "1.0.0"
	property string gameid: "Game ID here"
	property string gameserver: "ip:port"

	property int playercap: 5
	
	Connections {
			target: game_creation_ui

			function onGameidupdated(msg) {
				gameid = msg;
				console.log(gameid)
			}
			function onGameserverupdated(msg) {
				gameserver = msg;
				console.log(gameserver)
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
			anchors.fill: parent
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
					text: "Join Game"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
					}
					onClicked: {
						stack.push(Qt.createComponent("Join_Game.qml").createObject())
					}

				}
				Button {
					text: "Create Game"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
					}
					onClicked: {
						stack.push(Qt.createComponent("Create_Game.qml").createObject())
					}
				}

				Button {
					text: "Settings"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
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
    

