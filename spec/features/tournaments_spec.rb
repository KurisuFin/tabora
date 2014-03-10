require 'spec_helper'

describe 'Tournament' do
	let!(:event1) { FactoryGirl.create :event, name:'Happening' }
	let!(:event2) { FactoryGirl.create :event, name:'Another' }
	let!(:game1) { FactoryGirl.create :game, name:'The Game' }
	let!(:game2) { FactoryGirl.create :game, name:'The Peli' }
	let!(:tournament1) { FactoryGirl.create :tournament, event:event1, game:game1 }
	let!(:tournament2) { FactoryGirl.create :tournament, event:event1, game:game2 }
	let!(:tournament3) { FactoryGirl.create :tournament, name:'Nintendo Challenge', event:event2, game:game2 }

	# INDEX
	it 'is listed on index page' do
		visit tournaments_path

		expect(page).to have_content('The Game')
		expect(page).to have_content('The Peli')
		expect(page).to have_content('Nintendo Challenge')
	end


	# SHOW
	it 'has own page with title' do
		visit tournament_path(Tournament.find_by name:'Nintendo Challenge')

		expect(page).to have_content('Nintendo Challenge')
		expect(page).not_to have_content('The Game')
	end

	it 'can be visited from index page' do
		visit tournaments_path
		click_link 'Nintendo Challenge'

		expect(page).to have_content('Nintendo Challenge')
		expect(page).not_to have_content('The Game')
	end


	# NEW
	it 'can be created with name from new event tournament page' do
		visit new_event_tournament_path(event2)
		fill_in 'tournament_name', with:'New tournament'
		select 'The Game', from:'tournament_game_id'

		expect {
			click_button 'Create Tournament'
		}.to change{Tournament.count}.from(3).to(4)
		expect(page).to have_content('New tournament')
	end

	it 'can be created without name from new event tournament page' do
		visit new_event_tournament_path(event2)
		select 'The Game', from:'tournament_game_id'

		expect {
			click_button 'Create Tournament'
		}.to change{Tournament.count}.from(3).to(4)
		expect(page).to have_content('The Game')
	end

	# EDIT
	it 'can be edited and is updated with name' do
		visit edit_tournament_path(tournament1)
		fill_in 'tournament_name', with:'New name'
		select 'The Peli', from:'tournament_game_id'
		click_button 'Update Tournament'

		expect(page).to have_content 'New name'
		expect(page).to have_content 'The Peli'
		expect(page).not_to have_content 'The Game'
	end

	it 'can be edited and is updated without name' do
		visit edit_tournament_path(tournament3)
		fill_in 'tournament_name', with:''
		select 'The Game', from:'tournament_game_id'
		click_button 'Update Tournament'

		expect(page).to have_content 'The Game'
		expect(page).not_to have_content 'The Peli'
	end
end