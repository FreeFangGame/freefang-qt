class Game_Creation:
	def __init__(self, playercap):
		self.action = "game_create"
		self.headers = {
			"playercap": playercap
		}
