require 'spec_helper'

describe 'Event' do
	let!(:event1) { FactoryGirl.create(:event) }
	let!(:event2) { FactoryGirl.create(:event, name:'Anothers') }

	it 'is listed on index page' do
		visit events_path

		expect(page).to have_content('Happening')
	end

	it 'is listed on index page with another event' do
		visit events_path

		expect(page).to have_content('Happening')
		expect(page).to have_content('Another')
	end
end