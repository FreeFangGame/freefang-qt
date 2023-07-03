import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

ActionButton{
    text: qsTr("Kill")
	onClicked: {
		game_loop.witch_kill(player)
	}
}