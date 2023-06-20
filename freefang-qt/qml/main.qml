import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material 


ApplicationWindow {
    visible: true
    width: 1920
    height: 1080
    visibility: "Maximized"
    title: "freefang-qt"
    property string version: "1.0.0"

    StackView {

        id: stack
        initialItem: mainmenu
        anchors.fill: parent
    }
    
    Component {
        id: mainmenu
        
			ColumnLayout{
			anchors.fill: parent
				Rectangle { 
					Layout.alignment : Qt.AlignHCenter 
					Layout.topMargin: 75
					color: 'teal'
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					Text {
						anchors.centerIn: parent
						font.pointSize: 24
						text: "FreeFang-QT"
					}
				}
				Button {
					text: "Join Game"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
					}

				}
				Button {
					text: "Create Game"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
					}
				}

				Button {
					text: "Settings"
					Layout.alignment : Qt.AlignHCenter 
					Layout.fillWidth: true
					Layout.maximumWidth: 300
					Layout.minimumHeight: 75
					background: Rectangle {
						border.width: 1
					}
				}

				Item {
					// Spacer
					Layout.fillHeight: true
				}

			
        }
        

}
}
    

