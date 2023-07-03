import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 


ActionButton{
    text: qsTr("Revive")
	onClicked: {
		game_loop.witch_revive(player)
	}
}
