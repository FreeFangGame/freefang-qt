import socket
from freefang_qt import utils, net, packets
import select
from PySide6.QtCore import Slot, QObject, Signal, QTimer
from freefang_qt.data import global_data



class Player:
	def __init__(self, name):
		self.name = name
		self.role = None
		self.alive = True
		

class Game_loop(QObject):
	
	
	chatupdate = Signal(str, arguments=['message'])
	playeradd = Signal(str, arguments=['player'])
	playerrm = Signal(str, arguments=['player'])
	# See Game_UI.qml

	setaction = Signal(str, arguments=['action'])
	remove_buttons = Signal()
	playername = ""
	time = ""
	up = ""
	role = ""
	players = []
	game_started = False


	def __init__(self):
		super(Game_loop, self).__init__()
		
	def handle_time_change(self, packet):
		self.remove_buttons.emit()
		if packet.headers.time == "day":
			self.chatupdate.emit("The village wakes up")

		else:
			self.chatupdate.emit("The village falls asleep")
		self.time = packet.headers.time
			
	def handle_role_attribution(self, packet):
		self.chatupdate.emit(f"You have been attributed the role {packet.headers.role}")
		self.role = packet.headers.role

	def handle_role_wakeup(self, packet):
		self.chatupdate.emit(f"The role: {packet.headers.role} wakes up")
		
		# Associate different roles to their action buttons
		role_to_btn = {
			"Werewolf": "Werewolfvote",
			"Seer": "SeerReveal",
			"Hunter": "HunterKill",
			"Protector": "ProtectorProtect"
		}
		
		btn = role_to_btn[packet.headers.role]
		self.up = packet.headers.role
		
		if packet.headers.role == self.role:
			self.setaction.emit(btn)

			
	def handle_player_death(self, packet):
		self.chatupdate.emit(f"{packet.headers.name} died, he had the role {packet.headers.role}")
		
		if packet.headers.name == self.playername:
			self.chatupdate.emit("You have died, you are now a spectator")
			if self.role == "Hunter":
				self.chatupdate.emit("You were the hunter, pick a player to kill.")

				self.setaction.emit("HunterKill")
		self.getplayerbyname(packet.headers.name).alive = False


		
	def handle_town_vote(self, packet):
		self.chatupdate.emit(f"{packet.headers.sender} votes for {packet.headers.target}")
		
	def handle_game_end(self, packet):
		self.remove_buttons.emit()
		if packet.headers.outcome == "werewolf_win":
			self.chatupdate.emit("The werewolves have won")
		elif packet.headers.outcome == "town_win":
			self.chatupdate.emit("The village has won")
			
	def handle_added_to_game(self, packet):
		self.chatupdate.emit("You have joined the game")
		for i in packet.headers.players:
			self.playeradd.emit(i)
			spl = Player(i)
			self.players.append(spl)
		self.playername = packet.headers.username
	def handle_player_join(self, packet):
		self.chatupdate.emit(f"{packet.headers.name} joined the game")
		self.playeradd.emit(packet.headers.name)
		spl = Player(packet.headers.name)
		self.players.append(spl)

	def handle_chat_message(self, packet):
		self.chatupdate.emit(f"{packet.headers.sender}: {packet.headers.message}")
		
	def handle_seer_role_reveal(self, packet):
		self.chatupdate.emit(f"{packet.headers.name} has the role {packet.headers.role}")
	def begin_town_vote(self, packet):
		self.chatupdate.emit("The town may now vote")
		self.setaction.emit("Vote")
	def handle_leave(self, packet):
		self.chatupdate.emit(f"{packet.headers.name} disconnected")
		self.playerrm.emit(packet.headers.name)

	def handle_werewolf_vote(self, packet):
		self.chatupdate.emit(f"{packet.headers.sender} votes for {packet.headers.target}")

		

	def getplayerbyname(self, player):
		return [i for i in self.players if i.name == player][0]

	@Slot(str, result=bool)
	def isalive(self, player):
		spl = self.getplayerbyname(player)
		return spl.alive
		
	
	def handle_packet(self, packet):
		packet_to_func = {
			"time_change": self.handle_time_change,
			"role_attributed": self.handle_role_attribution,
			"role_wakeup": self.handle_role_wakeup,
			"player_death": self.handle_player_death,
			"town_vote": self.handle_town_vote,
			"game_end": self.handle_game_end,
			"added_to_game": self.handle_added_to_game,
			"player_join": self.handle_player_join,
			"chat_message": self.handle_chat_message,
			"seer_role_reveal": self.handle_seer_role_reveal,
			"town_vote_begin": self.begin_town_vote,
			"player_leave": self.handle_leave,
			"werewolf_vote": self.handle_werewolf_vote
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
					pass
			except:
				return
			
				
		
	@Slot()
	def start_game_loop(self):
		global_data.socket.setblocking(0)
		self.timer = QTimer()
		self.timer.setInterval(300)
		self.timer.timeout.connect(self.select_loop)
		self.timer.start()
	
	@Slot(str)
	def vote(self, player):
		self.remove_buttons.emit()
		vt = packets.Town_Vote(player)
		packet = utils.object_to_json(vt)
		net.send_packet(packet, global_data.socket)
		
		
	@Slot(str)
	def werewolfvote(self, player):
		self.remove_buttons.emit()
		vt = packets.Werewolf_Vote(player)
		packet = utils.object_to_json(vt)
		net.send_packet(packet, global_data.socket)
		
	@Slot(str)
	def chat_message(self, msg):
		msgpacket = 0
		
		if self.time == "day":
			msgpacket = packets.Town_message(msg)
		elif self.up == "Werewolf" and self.role == "Werewolf":
			msgpacket = packets.Werewolf_message(msg)	
		elif self.role == "":
			msgpacket = packets.Pre_game_message(msg)
		packet = utils.object_to_json(msgpacket)
		net.send_packet(packet, global_data.socket)
		
	@Slot(str)
	def seer_reveal(self, player):
		self.remove_buttons.emit()

		packet = utils.object_to_json(packets.Seer_reveal(player))
		net.send_packet(packet, global_data.socket)

	@Slot(str)
	def hunter_kill(self, player):
		self.remove_buttons.emit()
		
		packet = utils.object_to_json(packets.Hunter_kill(player))
		net.send_packet(packet, global_data.socket)

	@Slot(str)
	def protector_protect(self, player):
		self.remove_buttons.emit()
		packet = utils.object_to_json(packets.Protector_protect(player))
		net.send_packet(packet, global_data.socket)

		
			
