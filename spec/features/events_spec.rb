require 'spec_helper'

describe 'Event' do
	let!(:event1) { FactoryGirl.create(:event) }
	let!(:event2) { FactoryGirl.create(:event, name:'Another') }

	it 'is listed on index page' do
		visit events_path

		expect(page).to have_content('Happening')
	end

	it 'is listed on index page with another event' do
		visit events_path

		expect(page).to have_content('Happening')
		expect(page).to have_content('Another')
	end


	it 'has own page' do
		visit event_path(event2)

		expect(page).to have_content('Another')
		expect(page).not_to have_content('Happening')
	end

	it 'page can be accessed from index page' do
		visit events_path
		click_link 'Another'

		expect(page).to have_content('Another')
		expect(page).not_to have_content('Happening')
	end
end