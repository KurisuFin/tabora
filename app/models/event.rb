class Event < ActiveRecord::Base
	has_many :operators
	has_many :tournaments, dependent: :destroy

	validates :name,
						presence: true,
						uniqueness: true
end
