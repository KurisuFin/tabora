class User < ActiveRecord::Base
	has_many :operators, dependent: :destroy
	has_many :operated_events, through: :operators, source: :events
	has_many :participations, dependent: :destroy
	has_many :tournaments, through: :participations

	validates :username,
						uniqueness: true,
						length: { minimum: 3 }

	#TODO Password things
	def self.authenticate(username)
		User.find_by username:username
	end

	def is_admin?
		self.admin
	end

	def is_participant_of(tournament)
		Tournament.find(tournament).participants.exists? self
	end


	def is_operator_of(event)
		# Admin is automatically operator of all events
		self.is_admin? || event.operating_users.exists?(self)
	end
end
