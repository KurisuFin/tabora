class User < ActiveRecord::Base
	has_many :operators
	has_many :operated_events, through: :operators, source: :events
	has_many :participations
	has_many :tournaments, through: :participations

	validates :username,
						uniqueness: true,
						length: { minimum: 3 }

	#TODO Password things
	def self.authenticate(username)
		User.find_by username:username
	end

	def is_participating_of(tournament)
		Tournament.find(tournament).participants.exists? self
	end

	def is_operator_of(event)
		Event.find(event).operators.exists? self
	end
end
