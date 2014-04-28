require 'spec_helper'

describe Event do
	it 'is saved with proper name' do
		event = Event.create name:'Happening'

		expect(event).to be_valid
		expect(Event.count).to eq(1)
	end

	it 'is not saved without name' do
		event = Event.create name:''

		expect(event).not_to be_valid
		expect(Event.count).to eq(0)
	end

	it 'is not saved if name is already taken' do
		event1 = Event.create name:'Happening'
		event2 = Event.create name:'Happening'

		expect(event2).not_to be_valid
		expect(Event.count).to eq(1)
	end

	it 'can be deleted' do
		event = Event.create name:'Happening'

		expect {
			event.delete
		}.to change{Event.count}.from(1).to(0)
	end

	describe 'method' do
		let!(:event) { FactoryGirl.create :event }

		it 'has_enroll_tournaments? returns true if event has atleast one tournament in enroll phase' do
			FactoryGirl.create(:tournament, event:event)
			FactoryGirl.create(:tournament, event:event, phase:'ongoing')

			expect(event.has_enroll_tournaments?).to be(true)
		end

		it 'has_enroll_tournaments? returns false if event doesn\'t have any tournaments in enroll phase' do
			FactoryGirl.create(:tournament, event:event, phase:'ongoing')
			FactoryGirl.create(:tournament, event:event, phase:'ended')

			expect(event.has_enroll_tournaments?).to be(false)
		end

		it 'has_ongoing_tournaments? returns true if event has atleast one tournament in ongoing phase' do
			FactoryGirl.create(:tournament, event:event)
			FactoryGirl.create(:tournament, event:event, phase:'ongoing')

			expect(event.has_ongoing_tournaments?).to be(true)
		end

		it 'has_ongoing_tournaments? returns false if event doesn\'t have any tournaments in ongoing phase' do
			FactoryGirl.create(:tournament, event:event)
			FactoryGirl.create(:tournament, event:event, phase:'ended')

			expect(event.has_ongoing_tournaments?).to be(false)
		end
	end
end