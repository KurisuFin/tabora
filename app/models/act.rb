class Act < ActiveRecord::Base
	belongs_to :user
	belongs_to :battle

	def score
		super || 0
	end

	def score_plus_one
		self.score + 1
	end
end
