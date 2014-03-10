require 'spec_helper'

describe 'Event' do
	let!(:event1) { FactoryGirl.create(:event, name:'Happening') }
	let!(:event2) { FactoryGirl.create(:event, name:'Another') }


	# INDEX
	it 'is listed on index page' do
		visit events_path

		expect(page).to have_content('Happening')
		expect(page).to have_content('Another')
	end

	it 'is listed on index page with another event' do
		visit events_path

		expect(page).to have_content('Happening')
		expect(page).to have_content('Another')
	end


	# SHOW
	it 'has own page with title' do
		visit event_path(event1)

		expect(page).to have_content 'Happening'
		expect(page).to have_content 'Create new tournament'
	end

	it 'can be visited from index page' do
		visit events_path
		click_link 'Another'

		expect(page).to have_content('Another')
		expect(page).to have_content 'Create new tournament'
		expect(page).not_to have_content('Happening')
	end


	# NEW
	it 'is saved with valid name' do
		visit new_event_path
		fill_in 'event_name', with:'Newbie event'

		expect {
			click_button 'Create Event'
		}.to change{Event.count}.from(2).to(3)
	end

	it 'is not saved without name' do
		visit new_event_path

		click_button 'Create Event'

		expect(Event.count).to eq(2)
		expect(page).to have_content 'Name can\'t be blank'
	end

	it 'is not saved if name is taken' do
		visit new_event_path
		fill_in 'event_name', with:'Happening'
		click_button 'Create Event'

		expect(Event.count).to eq(2)
		expect(page).to have_content 'Name has already been taken'
	end


	# EDIT
	it 'can be edited and is updated with valid name' do
		visit edit_event_path(event1)
		fill_in 'event_name', with:'New name'
		click_button 'Update Event'

		expect(page).to have_content 'New name'
		expect(page).not_to have_content 'Happening'
	end

	it 'is not updated without name' do
		visit edit_event_path(event1)
		fill_in 'event_name', with: ''
		click_button 'Update Event'

		expect(page).to have_content 'Name can\'t be blank'
	end

	it 'is not updated if name is taken' do
		visit edit_event_path(event1)
		fill_in 'event_name', with: 'Another'
		click_button 'Update Event'

		expect(page).to have_content 'Name has already been taken'
	end


	# DESTROY
	it 'can be deleted if current user is admin'
	it 'cannot be deleted if current user is not admin'
end