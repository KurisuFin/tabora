class Tournament < ActiveRecord::Base
	belongs_to :event
	belongs_to :game
	has_many :participations
	has_many :participants, through: :participations, source: :user

	validates :game, presence: true

	# Returns name of tournament. If no name is given returns name of game.
	def name
		super || game.name
	end
end
