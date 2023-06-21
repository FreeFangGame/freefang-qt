import socket
import packets
import net
import utils
import select
from PySide6.QtCore import Slot, QObject, Signal, QTimer
from data import global_data


class Game_loop(QObject):
	
	chatupdate = Signal(str, arguments=['message'])
	
	def select_loop(self):
		print("selectloop")

		msgqueue = {}
		try:
			packet = net.read_packet(global_data.socket)
		except:
			return
		self.chatupdate.emit(packet)
		
	@Slot()
	def start_game_loop(self):
		print("Starting timer")
		global_data.socket.setblocking(0)
		self.timer = QTimer()
		self.timer.setInterval(100)
		self.timer.timeout.connect(self.select_loop)
		self.timer.start()
		
		


