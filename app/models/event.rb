class Event < ActiveRecord::Base
	has_many :operators, dependent: :destroy
	has_many :operating_users, through: :operators, source: :user
	has_many :tournaments, dependent: :destroy

	validates :name,
						presence: true,
						uniqueness: true

	def has_enroll_tournaments?
		Tournament.where(event:self, phase:'enroll').any?
	end

	def has_ongoing_tournaments?
		Tournament.where(event:self, phase:'ongoing').any?
	end
end
