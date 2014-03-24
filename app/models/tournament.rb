class Tournament < ActiveRecord::Base
	belongs_to :event
	belongs_to :game
	belongs_to :setup
	has_many :participations, dependent: :destroy
	has_many :participants, through: :participations, source: :user
	has_many :battles

	validates :game, presence: true
	validates :event, presence: true

	# Returns name of tournament. If no name is given returns name of game.
	def name
		super || game.name
	end
end
