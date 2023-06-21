// QML for the UI used to interact with an ongoing game (vote, chat, etc)

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 



RowLayout{

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
			 ListElement { message: "0" }
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
       ColumnLayout {
       id: players
       width: 100
		   Rectangle {
				color: "red"
				Layout.fillHeight: true
				Layout.fillWidth: true
		   }
       }
				Connections {
						target: game_loop

						function onChatupdate(msg) {
							console.log(msg)
							chatmodel.append({message: msg})
						}
				}
}
