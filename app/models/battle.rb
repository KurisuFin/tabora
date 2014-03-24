class Battle < ActiveRecord::Base
	belongs_to :tournament
	has_many :acts
	has_many :players, through: :acts, source: :user

	has_many :battle_connections
	has_many :postbattles, through: :battle_connections
	has_many :inverse_battle_connections, class_name: 'BattleConnection', foreign_key: 'postbattle_id'
	has_many :prebattles, through: :inverse_battle_connections, source: :battle


	def state
		return 'pending' if acts.empty?

		acts.each do |act|
			return 'pending' if act.score.nil?
		end

		'finished'
	end
end
