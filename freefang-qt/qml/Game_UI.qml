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
					text: " " + player
					color: "white"
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
					text: " " + message
					color: "white"

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
		
		Rectangle {
			color: "black"
			Layout.fillHeight: true
			Layout.fillWidth: true
			border.color: "#555555"
			border.width: 2
			width: 300


			ColumnLayout{

				id: chatlayout
				height: parent.height
				width: parent.width
				ScrollView {
					height: 180
					Layout.fillHeight: true
					Layout.fillWidth: true

					ScrollBar.vertical.policy: ScrollBar.AsNeeded
					ListView {
						anchors.topMargin: 20
						anchors.leftMargin: 50
						Layout.fillHeight: true
						Layout.fillWidth: true
					   
						id: chat
						model: chatmodel
						delegate: chatdelegate

					}

			   }
				TextField{
						id: chat_input
						placeholderText: "Message"
						height: 10
						Layout.fillWidth: true
						placeholderTextColor: "darkgray"
						font.pointSize: 14

						color: 'white'
						Keys.onReturnPressed: {
							game_loop.chat_message(chat_input.text)
							chat_input.text = ""
						}


				}
		}




		   
		}
		Rectangle {
			color: "black"
			border.color: "#555555"
			border.width: 2		
			Layout.fillHeight: true
			Layout.fillWidth: true	
			width: 100

			ScrollView {
			
				width: parent.width
				height: parent.height
			   
				ScrollBar.vertical.policy: ScrollBar.AsNeeded
				ListView {
					Layout.fillHeight: true
					Layout.fillWidth: true
				   
					id: players
					model: playermodel
					delegate: playerdelegate

				}

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
							switch(act){
								case "vote":
									btn = "VoteButton.qml";
									break
								case "werewolfvote":
									btn = "Werewolfvotebutton.qml";
									break

							}
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								if (playermodel.get(i).player != game_loop.playername){
									playermodel.get(i).buttonsrc = btn;
								}
							}
						}
						function onRemove_buttons(){
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								playermodel.get(i).buttonsrc = "";
							}
						}
				}
}
