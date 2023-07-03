import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

ActionButton{
    text: qsTr("Protect")
	onClicked: {
		game_loop.protector_protect(player)
	}
}