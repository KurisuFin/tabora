require 'spec_helper'

describe 'Event page' do
	let!(:event1) { FactoryGirl.create(:event) }
	let!(:event2) { FactoryGirl.create(:event, name:'Another') }

	it 'can be accessed from index page' do
		visit events_path
		click_link 'Another'

		expect(page).to have_content('Another')
		expect(page).not_to have_content('Happening')
	end
end