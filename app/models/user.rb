class User < ActiveRecord::Base
	has_many :participations
	has_many :tournaments, through: :participations

	#TODO Password things
	def self.authenticate(username)
		User.find_by(username: username)
	end


	def is_participating_of(tournament)
		Tournament.find(tournament).participants.exists?(self)
	end
end
