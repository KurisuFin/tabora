FactoryGirl.define do
	uuid = UUID.new

	factory :user do
		username { uuid.generate }
		password 'secret'
		password_confirmation 'secret'
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
		phase 'enroll'
	end

	factory :operator do
		user
		event
	end

	factory :participation do
		user
		tournament
	end

	factory :act do
		user
		battle
	end

	factory :battle do
		tournament
	end
end