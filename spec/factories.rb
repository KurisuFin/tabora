FactoryGirl.define do
	factory :user do
		username 'Jack'
	end

	factory :event do
		name 'Happening'
	end

	factory :game do
		name 'The Game'
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