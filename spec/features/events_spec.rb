require 'spec_helper'
include OwnTestHelper

describe 'Event' do
	let!(:event1) { FactoryGirl.create :event, name:'Happening' }
	let!(:event2) { FactoryGirl.create :event, name:'Another' }


	# INDEX
	it 'is listed on index page' do
		visit events_path

		expect(page).to have_content('Happening')
		expect(page).to have_content('Another')
	end


	# SHOW
	it 'has own page with title' do
		visit event_path(event1)

		expect(page).to have_content 'Happening'
		expect(page).not_to have_content 'Another'
	end

	it 'can be visited from index page' do
		visit events_path
		click_link 'Happening'

		expect(page).to have_content('Happening')
		expect(page).not_to have_content('Another')
	end


	# NEW
	it 'cannot be created if no user is logged in' do
		expect {
			visit new_event_path
		}.to raise_error ActionController::RoutingError
	end

	it 'cannot be created if logged user is not operator of event' do
		user = FactoryGirl.create :user
		login(username:user.username)

		expect {
			visit new_event_path
		}.to raise_error ActionController::RoutingError
	end


	# EDIT
	it 'cannot be edited if no user is logged in' do
		expect {
			visit edit_event_path(event1)
		}.to raise_error ActionController::RoutingError
	end

	it 'cannot be edited if logged user is not operator of event' do
		user = FactoryGirl.create :user
		login(username:user.username)

		expect {
			visit edit_event_path(event1)
		}.to raise_error ActionController::RoutingError
	end
end