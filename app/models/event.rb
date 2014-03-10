class Event < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_many :operators
	has_many :operating_user, through: :operators, source: :users
	has_many :tournaments, dependent: :destroy
end
