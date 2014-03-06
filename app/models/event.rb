class Event < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_many :tournaments, dependent: :destroy
end
