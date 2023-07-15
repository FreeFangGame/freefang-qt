import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

ActionButton{
    text: qsTr("Infatuate")
	onClicked: {
		game_loop.cupid_infatuate(player)
	}
}