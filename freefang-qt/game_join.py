import socket
import packets
import net
import utils
from PySide6.QtCore import Slot, QObject, Signal
from data import global_data

class Game_join(QObject):
	
    
	@Slot(str, str, str)
	def join_game(self, server, name, gameid):
		ip = server.split(":")[0]
		port = server.split(":")[1]
		
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.connect((ip, int(port)))
		net.send_packet(utils.object_to_json(packets.Game_Join(name=name, gameid=gameid)), sock)
		global_data.socket = sock
		print(net.read_packet(sock))
