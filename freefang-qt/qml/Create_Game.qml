import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 



ColumnLayout{

			anchors.fill: parent
			spacing: 10
				Rectangle { 
					Layout.alignment : Qt.AlignHCenter | Qt.AlignTop
					Layout.topMargin: 75
					color: 'teal'
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					Text {
						anchors.centerIn: parent
						font.pointSize: 24
						text: "Game Creation"
					}
				}

				TextField{
					id: gamecreation_server
					placeholderText: "Server"
					text: "127.0.0.1:9999"
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true
					color: 'black'


				}
				TextField{
					id: gamecreation_playercap
					placeholderText: "Players"
					text: "5"
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true
					color: 'black'


				}
				Button {
					text: "Done"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
					}
					onClicked: {
						game_creation_ui.create_game(gamecreation_server.text, gamecreation_playercap.text)
						stack.pop()
						stack.push(Qt.createComponent("Join_Game.qml").createObject())

					}

				}
				
				Item {
					// Spacer
					Layout.fillHeight: true
				}
}

