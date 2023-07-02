import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

Button {
	id: seerrevealbtn
	property string player
	text: qsTr("Reveal")
	onClicked: {
		game_loop.seer_reveal(player)
	}
	background: Rectangle {
		border.width: 1
		color: "black"
		border.color: "white"

		

	}
    contentItem: Text {
        text: seerrevealbtn.text
        font.pixelSize: 12
		color: "white"
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
