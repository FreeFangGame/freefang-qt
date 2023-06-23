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
