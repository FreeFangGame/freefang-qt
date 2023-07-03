import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 


ActionButton{
    text: qsTr("Vote")
	onClicked: {
		game_loop.vote(player)
	}
}