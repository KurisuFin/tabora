FactoryGirl.define do
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
end