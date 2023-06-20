import socket
import packets
import net
import utils
from PySide6.QtCore import Slot, QObject


class Game_creation(QObject):
	@Slot(str, str)
	def create_game(self, s, playercap):
		ip = s.split(":")[0]
		port = s.split(":")[1]
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.connect((ip, int(port)))
		net.send_packet(utils.object_to_json(packets.Game_Creation(playercap=int(playercap))), sock)
