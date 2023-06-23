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
						text: "Game Join"
					}
				}

				TextField{
					id: gamejoin_server
					placeholderText: "Server"
					text: gameserver
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24
					color: "white"

					Layout.fillWidth: true


				}
				TextField{
					id: gamejoin_gameid
					placeholderText: "Game ID"
					text: gameid
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24
					color: "white"

					Layout.fillWidth: true


				}
				TextField{
					id: gamejoin_name
					placeholderText: "Name"
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true
					color: "white"

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
						game_join_ui.join_game(gamejoin_server.text, gamejoin_name.text, gamejoin_gameid.text);
						stack.pop();
						var component = Qt.createComponent("Game_UI.qml");
						if( component.status != Component.Ready )
						{
							if( component.status == Component.Error )
								console.debug("Error:"+ component.errorString() );
							return;
						}else{
							stack.push(component.createObject())
							game_loop.playername = gamejoin_name.text
							game_loop.start_game_loop()
							

						}
						
					}

				}
				
				Item {
					// Spacer
					Layout.fillHeight: true
				}

}
