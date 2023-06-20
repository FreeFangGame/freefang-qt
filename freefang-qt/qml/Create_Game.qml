import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 



ColumnLayout{
			anchors.fill: parent
			spacing: 2
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

				TextInput{
					id: gamecreation_server
					text: "ip:port"
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true
					color: 'black'


				}
				TextInput{
					id: gamecreation_playercap
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
					}

				}
				
				Item {
					// Spacer
					Layout.fillHeight: true
				}
}

