import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

Button {
	id: hunterkillbtn
	property string player
	text: qsTr("Kill")
	onClicked: {
		game_loop.hunter_kill(player)
	}
	background: Rectangle {
		border.width: 1
		color: "black"
		border.color: "white"

		

	}
    contentItem: Text {
        text: hunterkillbtn.text
        font.pixelSize: 12
		color: "white"
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
