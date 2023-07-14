import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 


ActionButton{
    text: qsTr("Pass turn")
	onClicked: {
		game_loop.witch_pass_turn()
	}
}
