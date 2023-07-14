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
					width: parent.width
					height: 10
				Label {
					text: " " + player
					color: "white"
					font.pixelSize: 23
				}
				Loader{
					    source: buttonsrc
						
						onLoaded: {
							item.player = player
						}

				}
				}

			}
		}
		Component {
			id: chatdelegate
			Label {
				id: chatlabel
				width: chat.width
				text: " " + message
				color: "white"

				wrapMode: Text.Wrap

			}
		}

		ListModel {
			 id: chatmodel
		}
		ListModel {
			 id: playermodel
		}
		id: gameui
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
					id: chatsv
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
					spacing: 13
					Layout.fillHeight: true
					Layout.fillWidth: true
				   
					id: players
					model: playermodel
					delegate: playerdelegate
					clip: true

				}

		   }
		}

				Connections {
						target: game_loop

						function onChatupdate(msg) {
							chatmodel.append({message: msg})
							chatsv.contentItem.contentY = chatsv.contentItem.contentHeight;
						}
						function onPlayeradd(spl){

							playermodel.append({player: spl, buttonsrc: ""})

						}
						function onPlayerrm(spl){
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								if (playermodel.get(i).player == spl){
									playermodel.remove(i)
								}
							}
							
						}
						function onSetaction(act){
							var btn = act + ".qml";
							if (!game_loop.isalive(game_loop.playername)){
								return;
							}
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								if (playermodel.get(i).player != game_loop.playername && game_loop.isalive(playermodel.get(i).player)){
									playermodel.get(i).buttonsrc = btn;
								}
								if (act == "Werewolfvote" && game_loop.iswerewolf(playermodel.get(i).player)){
									playermodel.get(i).buttonsrc = "";
								}
							}
						}
						function onRemove_buttons(){
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								playermodel.get(i).buttonsrc = "";
							}
						}
						function onWitchaction(deaths){
							for( var i = 0; i < playermodel.rowCount(); i++ ) {
								if (playermodel.get(i).player != game_loop.playername && game_loop.isalive(playermodel.get(i).player)){
									playermodel.get(i).buttonsrc = "Witch_kill.qml";
								} 
								if(deaths.indexOf(playermodel.get(i).player) > -1){
									playermodel.get(i).buttonsrc = "Witch_revive.qml"
								}
								if (playermodel.get(i).player == game_loop.playername){
									playermodel.get(i).buttonsrc = "Witchpassturnbtn.qml"

								}
							}
						}
				}
}
