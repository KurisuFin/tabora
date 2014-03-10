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
end