import socket
import packets
import net
import utils
from PySide6.QtCore import Slot, QObject, Signal


class Game_creation(QObject):
	gameidupdated = Signal(str, arguments=['id'])
	gameserverupdated = Signal(str, arguments=['server'])

	@Slot(str, str)
	def create_game(self, s, playercap):
		ip = s.split(":")[0]
		port = s.split(":")[1]
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.connect((ip, int(port)))
		net.send_packet(utils.object_to_json(packets.Game_Creation(playercap=int(playercap))), sock)
		resp = net.read_packet(sock)
		packet = utils.json_to_object(resp)
		print("PYTHON: " + packet.headers.id)
		self.gameidupdated.emit(packet.headers.id)
		self.gameserverupdated.emit(s)
