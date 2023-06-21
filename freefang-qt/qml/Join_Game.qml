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
						text: "Game Join"
					}
				}

				TextInput{
					id: gamejoin_server
					text: gameserver
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true
					color: 'black'


				}
				TextInput{
					id: gamejoin_gameid
					text: gameid
					Layout.alignment : Qt.AlignHCenter
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					font.pointSize: 24

					Layout.fillWidth: true
					color: 'black'


				}
				TextInput{
					id: gamejoin_name
					text: "Name here"
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
						game_join_ui.join_game(gameserver, gamejoin_name.text, gameid);
						stack.pop();
						var component = Qt.createComponent("Game_UI.qml");
						if( component.status != Component.Ready )
						{
							if( component.status == Component.Error )
								console.debug("Error:"+ component.errorString() );
							return;
						}else{
							stack.push(component.createObject())
							game_loop.start_game_loop()

						}
						
					}

				}
				
				Item {
					// Spacer
					Layout.fillHeight: true
				}
				Connections {
						target: game_loop

						function onChatupdate(msg) {
							console.log(msg)
							chatmodel.append({message: msg})
						}
				}
}
