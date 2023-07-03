import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 

Button {
	id: abtn
    property string player
	background: Rectangle {
		border.width: 1
		color: "black"
		border.color: "white"
	}
    contentItem: Text {
        text: abtn.text
        font.pixelSize: 12
		color: "white"
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
