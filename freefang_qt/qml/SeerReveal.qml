import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 


ActionButton{
    text: qsTr("Reveal Role")
	onClicked: {
		game_loop.seer_reveal(player)
	}
}