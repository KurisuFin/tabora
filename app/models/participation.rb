class Participation < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament

	validates :user, presence: true
	validates :tournament, presence: true
	validate :one_user_to_one_tournament

	def one_user_to_one_tournament
		return nil if user.nil? or tournament.nil?

		if Participation.where(user_id:user.id, tournament_id:tournament.id).exists?
			errors.add(:user, 'can join tournament only once')
		end
	end
end
