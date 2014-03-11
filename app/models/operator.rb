class Operator < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	validates :user, presence: true
	validates :event, presence: true
	validates :user_id, uniqueness: { scope: :event_id, message: 'is already event operator' }
end
