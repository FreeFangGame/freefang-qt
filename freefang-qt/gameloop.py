import socket
import packets
import net
import utils
import select
from PySide6.QtCore import Slot, QObject, Signal, QTimer
from data import global_data





class Game_loop(QObject):
	
	
	chatupdate = Signal(str, arguments=['message'])
	playeradd = Signal(str, arguments=['player'])
	setaction = Signal(str, arguments=['action'])
	playername = ""


	def __init__(self):
		super(Game_loop, self).__init__()
		
	def handle_time_change(self, packet):
		if packet.headers.time == "day":
			self.chatupdate.emit("The village wakes up")
			self.setaction.emit("vote")
		else:
			self.chatupdate.emit("The village falls asleep")
			
	def handle_role_attribution(self, packet):
		self.chatupdate.emit(f"You have been attributed the role {packet.headers.role}")

	def handle_role_wakeup(self, packet):
		self.chatupdate.emit(f"The role: {packet.headers.role} wakes up")
			
	def handle_player_death(self, packet):
		self.chatupdate.emit(f"{packet.headers.name} died, he had the role {packet.headers.role}")
	def handle_town_vote(self, packet):
		self.chatupdate.emit(f"{packet.headers.sender} votes for {packet.headers.target}")
	def handle_game_end(self, packet):
		if packet.headers.outcome == "werewolf_win":
			self.chatupdate.emit("The werewolves have won")
		elif packet.headers.outcome == "town_win":
			self.chatupdate.emit("The village has won")
	def handle_added_to_game(self, packet):
		self.chatupdate.emit("You have joined the game")
		for i in packet.headers.players:
			self.playeradd.emit(i)
	def handle_player_join(self, packet):
		self.chatupdate.emit(f"{packet.headers.name} joined the game")
		self.playeradd.emit(packet.headers.name)

		

	
	def handle_packet(self, packet):
		packet_to_func = {
			"time_change": self.handle_time_change,
			"role_attributed": self.handle_role_attribution,
			"role_wakeup": self.handle_role_wakeup,
			"player_death": self.handle_player_death,
			"town_vote": self.handle_town_vote,
			"game_end": self.handle_game_end,
			"added_to_game": self.handle_added_to_game,
			"player_join": self.handle_player_join
		}
		if packet_to_func.get(packet.action):
			packet_to_func[packet.action](packet)
			return 0
		else:
			return 1

	
	def select_loop(self):

		msgqueue = {}
		packet = ""
		while True:
			try:
				packet = net.read_packet(global_data.socket)
				obj = utils.json_to_object(packet)
				if self.handle_packet(obj):
					self.chatupdate.emit(packet)
			except:
				return
				
		
	@Slot()
	def start_game_loop(self):
		print("Starting timer")
		global_data.socket.setblocking(0)
		self.timer = QTimer()
		self.timer.setInterval(100)
		self.timer.timeout.connect(self.select_loop)
		self.timer.start()
	
	@Slot(str)
	def vote(self, player):
		vt = packets.Town_Vote(player)
		packet = utils.object_to_json(vt)
		net.send_packet(packet, global_data.socket)
		
		
		


