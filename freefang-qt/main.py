from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQml import QQmlApplicationEngine

import os
import sys
import game_creation

directory = os.path.dirname(os.path.realpath(__file__))

def main():
	game_creation_ui = game_creation.Game_creation()
	app = QApplication()
	engine = QQmlApplicationEngine()
	engine.quit.connect(app.quit)
	engine.rootContext().setContextProperty("game_creation_ui", game_creation_ui)
	engine.load(os.path.join(directory, "qml/main.qml"))

	sys.exit(app.exec())
if __name__ == "__main__":
	main()
