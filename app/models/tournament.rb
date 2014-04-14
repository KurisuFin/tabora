class Tournament < ActiveRecord::Base
	belongs_to :event
	belongs_to :game
	has_many :participations, dependent: :destroy
	has_many :participants, through: :participations, source: :user
	has_many :battles, dependent: :destroy

	validates :game, presence: true
	validates :event, presence: true

	# Returns name of tournament. If no name is given returns name of game.
	def name
		super || game.name
	end


	def update(tournament_params)
		if super(tournament_params)
			update_phase(tournament_params[:phase]) unless tournament_params[:phase].nil?
			true
		end
	end


	def update_phase(new_phase)
		case new_phase
			when 'ongoing'
				init_battles
			when 'ended'
				nil
		end
	end


	def init_battles
		battle_count = participants.count - 1
		create_battles battle_count
		set_postbattles battle_count
		create_acts
	end

	def create_battles(battle_count)
		(0..battle_count-1).each do |i|
			self.battles.create name:"Battle \##{i+1}"
		end
	end


	def set_postbattles(battle_count)
		(0..battle_count-2).each do |i|
			postbattle_index = (battle_count + 1) / 2 + i / 2
			self.battles[i].postbattles.push self.battles[postbattle_index]
		end
	end


	def create_acts
		randomized = participants.shuffle

		randomized.each.with_index do |participant, i|
			self.battles[i/2].acts.create user:participant
		end
	end
end
