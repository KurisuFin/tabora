class Participation < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament

	validates :user, presence: true
	validates :tournament, presence: true
	validates :user_id, uniqueness: { scope: :tournament_id, message: ' is already participating tournament' }
end
