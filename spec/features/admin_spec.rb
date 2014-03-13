require 'spec_helper'
include OwnTestHelper

describe 'Admin' do
	let!(:user) { FactoryGirl.create :user, username:'admin', admin:true }

	before :each do
		login(username:'admin')
	end


	# EVENT
	it 'can create event with valid name' do
		visit new_event_path
		fill_in 'event_name', with:'Newbie event'

		expect {
			click_button 'Create Event'
		}.to change{Event.count}.from(0).to(1)
	end

	it 'cannot create event without name' do
		visit new_event_path
		click_button 'Create Event'

		expect(Event.count).to eq(0)
		expect(page).to have_content 'Name can\'t be blank'
	end

	it 'cannot create event if name is taken' do
		FactoryGirl.create :event, name:'Happening'

		visit new_event_path
		fill_in 'event_name', with:'Happening'
		click_button 'Create Event'

		expect(Event.count).to eq(1)
		expect(page).to have_content 'Name has already been taken'
	end

	it 'can delete event' do
		event = FactoryGirl.create :event

		visit edit_event_path(event)

		expect {
			click_link 'Destroy event'
		}.to change{Event.count}.from(1).to(0)
	end
end
