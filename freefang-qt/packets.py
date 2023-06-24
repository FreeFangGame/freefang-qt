class Game_Creation:
	def __init__(self, playercap):
		self.action = "game_create"
		self.headers = {
			"playercap": playercap
		}

class Game_Join:
	def __init__(self, name, gameid):
		self.action = "game_join"
		self.headers = {
			"name": name,
			"gameid": gameid
		}

class Town_Vote:
	def __init__(self, name):
		self.action = "town_vote"
		self.headers = {
			"target": name,
		}

class Werewolf_Vote:
	def __init__(self, name):
		self.action = "werewolf_vote"
		self.headers = {
			"target": name,
		}

class Town_message:
	def __init__(self, message):
		self.action = "town_message"
		self.headers = {
			"message": message,
		}
		
class Werewolf_message:
	def __init__(self, message):
		self.action = "werewolf_message"
		self.headers = {
			"message": message,
		}
		
class Seer_reveal:
	def __init__(self, target):
		self.action = "seer_reveal"
		self.headers = {
			"target": target
		}

class Hunter_kill:
	def __init__(self, target):
		self.action = "hunter_kill"
		self.headers = {
			"target": target
		}
