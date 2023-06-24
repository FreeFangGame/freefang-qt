import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

Button {
	property string player
	text: "Reveal"
	onClicked: {
		game_loop.seer_reveal(player)
	}
}
