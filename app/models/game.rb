class Game < ActiveRecord::Base
	has_many :tournaments

	validates :name,
						presence: true,
						uniqueness: true
end
