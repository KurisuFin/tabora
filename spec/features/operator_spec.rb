require 'spec_helper'
include OwnTestHelper

describe 'Operator' do
	let!(:user) { FactoryGirl.create :user }
	let!(:event) { FactoryGirl.create :event }
	let!(:operator) { FactoryGirl.create :operator, user:user, event:event }

	before :each do
		login(username:user.username)
	end


	describe 'of event' do
		it 'can edit and update event with valid name' do
			visit edit_event_path(event)
			fill_in 'event_name', with:'New name'
			click_button 'Update Event'

			expect(page).to have_content 'New name'
			expect(page).not_to have_content 'Happening'
		end

		it 'cannot update event without name' do
			visit edit_event_path(event)
			fill_in 'event_name', with: ''
			click_button 'Update Event'

			expect(page).to have_content 'Name can\'t be blank'
		end

		it 'cannot update event if name is taken' do
			FactoryGirl.create :event, name:'Another'

			visit edit_event_path(event)
			fill_in 'event_name', with: 'Another'
			click_button 'Update Event'

			expect(page).to have_content 'Name has already been taken'
		end
	end


	describe 'of tournament' do
		let!(:game1) { FactoryGirl.create :game, name:'The Game' }
		let!(:game2) { FactoryGirl.create :game, name:'The Peli' }

		it 'can create tournament with name to event' do
			visit new_event_tournament_path(event)
			fill_in 'tournament_name', with:'New tournament'
			select 'The Game', from:'tournament_game_id'

			expect {
				click_button 'Create Tournament'
			}.to change{Tournament.count}.from(0).to(1)
			expect(page).to have_content('New tournament')
		end

		it 'can create tournament without name to event' do
			visit new_event_tournament_path(event)
			select 'The Game', from:'tournament_game_id'

			expect {
				click_button 'Create Tournament'
			}.to change{Tournament.count}.from(0).to(1)
			expect(page).to have_content('The Game')
		end

		it 'can edit and update tournament with name' do
			tournament = FactoryGirl.create :tournament, event:event, game:game1

			visit edit_tournament_path(tournament)
			fill_in 'tournament_name', with:'New name'
			select 'The Peli', from:'tournament_game_id'
			click_button 'Update Tournament'

			expect(page).to have_content 'New name'
			expect(page).to have_content 'The Peli'
			expect(page).not_to have_content 'The Game'
		end

		it 'can be edited and is updated without name' do
			tournament = FactoryGirl.create :tournament, event:event, game:game2

			visit edit_tournament_path(tournament)
			fill_in 'tournament_name', with:''
			select 'The Game', from:'tournament_game_id'
			click_button 'Update Tournament'

			expect(page).to have_content 'The Game'
			expect(page).not_to have_content 'The Peli'
		end
	end
end