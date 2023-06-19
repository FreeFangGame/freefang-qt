from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQml import QQmlApplicationEngine

import os
import sys

directory = os.path.dirname(os.path.realpath(__file__))

def main():
	app = QApplication()
	engine = QQmlApplicationEngine()
	engine.quit.connect(app.quit)
	engine.load(os.path.join(directory, "qml/main.qml"))
	sys.exit(app.exec_())
if __name__ == "__main__":
	main()
