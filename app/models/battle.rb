class Battle < ActiveRecord::Base
	belongs_to :tournament
	has_many :acts
	has_many :players, through: :acts, source: :user

	has_many :pre_battle

	def state
		acts.each do |act|
			return 'pending' if act.score.nil?
		end

		'finished'
	end
end
