module ApplicationHelper
	def show_battles(tournament)
		code = tournament.setup.show
		battles = tournament.battles
		code
	end
end
