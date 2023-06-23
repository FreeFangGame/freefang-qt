// QML for the UI used to interact with an ongoing game (vote, chat, etc)

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 



RowLayout{

		Component {
			id: playerdelegate

			Item {
				width: 200; height: 28
				RowLayout{
					Layout.fillHeight: true
					Layout.fillWidth: true
				Label {
					text: player
				}
				Loader{
					    source: buttonsrc
						focus: true
						
						onLoaded: {
							item.player = player
							console.log(player)
						}

				}
				}

			}
		}
		Component {
			id: chatdelegate
			Item {
				width: 200; height: 28
				Label {
					text: message
				}
			}
		}

		ListModel {
			 id: chatmodel
		}
		ListModel {
			 id: playermodel
		}
		id: gameui
		anchors.fill: parent
		spacing: 0
		ScrollView {
		width: 200
			Layout.fillHeight: true
			Layout.fillWidth: true
		   
			ScrollBar.vertical.policy: ScrollBar.AlwaysOn
			ListView {
				Layout.fillHeight: true
				Layout.fillWidth: true
			   
				id: chat
				model: chatmodel
				delegate: chatdelegate

			}

       }
		ScrollView {
		width: 100
			Layout.fillHeight: true
			Layout.fillWidth: true
		   
			ScrollBar.vertical.policy: ScrollBar.AlwaysOn
			ListView {
				Layout.fillHeight: true
				Layout.fillWidth: true
			   
				id: players
				model: playermodel
				delegate: playerdelegate

			}

       }
				Connections {
						target: game_loop

						function onChatupdate(msg) {
							console.log(msg)
							chatmodel.append({message: msg})
						}
						function onPlayeradd(spl){
							console.log(spl)

							playermodel.append({player: spl, buttonsrc: ""})

						}
						function onSetaction(act){
							var btn = "";
							if (act == "vote"){
								btn = "VoteButton.qml";
							}
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								if (playermodel.get(i).player != game_loop.playername){
									playermodel.get(i).buttonsrc = btn;
								}
							}
						}
				}
}
