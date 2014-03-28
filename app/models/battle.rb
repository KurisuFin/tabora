class Battle < ActiveRecord::Base
	belongs_to :tournament
	has_many :acts
	has_many :players, through: :acts, source: :user

	has_many :battle_connections
	has_many :postbattles, through: :battle_connections
	has_many :inverse_battle_connections, class_name: 'BattleConnection', foreign_key: 'postbattle_id'
	has_many :prebattles, through: :inverse_battle_connections, source: :battle

	def finished?
		self.state == 'finished'
	end

	def state
		super || 'pending'
	end

	def update(battle_params)
		return nil unless are_scores_of_players_unique?

		if super(battle_params)
			if battle_params[:state] == 'finished'
					finish_battle
			end
		end
	end


	# TODO: Check scores from all players (now only two)
	def are_scores_of_players_unique?
		self.acts[0].score != self.acts[1].score
	end


	def finish_battle
		add_acts_to_postbattles
	end


	def add_acts_to_postbattles
		ordered_acts = self.acts.sort_by { |act| -act.score}

		self.postbattles.each.with_index do |postbattle, index|
			postbattle.acts.create user: ordered_acts[index].user
		end
	end


	def get_unfinished_prebattles
		prebattles.inject([]) do |table, prebattle|
			table.push prebattle unless prebattle.finished?
			table
		end
	end
end
