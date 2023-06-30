import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 



ColumnLayout{

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
					color: "white"

					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true


				}
				TextField{
					id: gamecreation_playercap
					placeholderText: "Players"
					text: "5"
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24
					color: "white"
					Layout.fillWidth: true


				}
				TextArea{
					id: ruleset
					text: "Villager: 4\nWerewolf: 1\ntown_voting_scheme: relmaj\nwerewolf_voting_scheme: unanimity"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
				}
				Button {
					text: "<font color=\"white\">Done</font>"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
						color: "black"
					}
					onClicked: {
						game_creation_ui.create_game(gamecreation_server.text, gamecreation_playercap.text, ruleset.text)
						stack.pop()
						stack.push(Qt.createComponent("Join_Game.qml").createObject())

					}

				}
				
				Item {
					// Spacer
					Layout.fillHeight: true
				}
}

