import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

Button {
	property string player
	text: "Vote"
	onClicked: {
		game_loop.werewolfvote(player)
	}
}
