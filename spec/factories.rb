FactoryGirl.define do
	uuid = UUID.new

	factory :user do
		username { uuid.generate }
	end

	factory :event do
		name { uuid.generate }
	end

	factory :game do
		name { uuid.generate }
	end

	factory :tournament do
		event
		game
	end

	factory :participation do
		user
		tournament
	end
end