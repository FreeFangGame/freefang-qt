import socket
import packets
import net
import utils
from PySide6.QtCore import Slot, QObject, Signal


def parse_ruleset(ruleset):
	lines = ruleset.split("\n")
	ret = {}
	for i in lines:
		splt = i.split(":")
		ret[splt[0]] = int(splt[1])
	return ret


class Game_creation(QObject):
	gameidupdated = Signal(str, arguments=['id'])
	gameserverupdated = Signal(str, arguments=['server'])

	@Slot(str, str, str)
	def create_game(self, s, playercap, ruleset):
		ip = s.split(":")[0]
		port = s.split(":")[1]
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.connect((ip, int(port)))
		rs = parse_ruleset(ruleset)
		net.send_packet(utils.object_to_json(packets.Game_Creation(playercap=int(playercap), ruleset=rs)), sock)
		resp = net.read_packet(sock)
		packet = utils.json_to_object(resp)
		self.gameidupdated.emit(packet.headers.id)
		self.gameserverupdated.emit(s)
		sock.close()
