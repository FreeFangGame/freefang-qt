import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

Button {
	property string player
	text: "Kill"
	onClicked: {
		game_loop.hunter_kill(player)
	}
}
