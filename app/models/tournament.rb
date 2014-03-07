class Tournament < ActiveRecord::Base
	belongs_to :event
	belongs_to :game
	has_many :participations
	has_many :participants, through: :participations, source: :user
end
