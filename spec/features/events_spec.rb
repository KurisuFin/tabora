require 'spec_helper'

describe 'Event' do
	let!(:event1) { FactoryGirl.create(:event) }
	let!(:event2) { FactoryGirl.create(:event, name:'Another') }

	# Index
	it 'is listed on index page' do
		visit events_path

		expect(page).to have_content('Happening')
	end

	it 'is listed on index page with another event' do
		visit events_path

		expect(page).to have_content('Happening')
		expect(page).to have_content('Another')
	end


	# New
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
end