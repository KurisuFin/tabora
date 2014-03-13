require 'spec_helper'
include OwnTestHelper

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

	it 'has name of game if name for tournament is not given' do
		visit tournament_path(tournament1)

		expect(page).to have_content 'The Game'
	end

	it 'can be visited from index page' do
		visit tournaments_path
		click_link 'Nintendo Challenge'

		expect(page).to have_content('Nintendo Challenge')
		expect(page).not_to have_content('The Game')
	end


	# NEW
	it 'cannot be created if no user is logged in' do
		expect {
			visit new_event_tournament_path(event1)
		}.to raise_error ActionController::RoutingError
	end

	it 'cannot be created if logged user is not operator of event' do
		user = FactoryGirl.create :user
		login(username:user.username)

		expect {
			visit new_event_tournament_path(event1)
		}.to raise_error ActionController::RoutingError
	end


	# EDIT
	it 'cannot be edited if no user is logged in' do
		expect {
			visit edit_tournament_path(tournament1)
		}.to raise_error ActionController::RoutingError
	end

	it 'cannot be edited if logged user is not operator of event' do
		user = FactoryGirl.create :user
		login(username:user.username)

		expect {
			visit edit_tournament_path(tournament1)
		}.to raise_error ActionController::RoutingError
	end
end