require 'spec_helper'

describe Event do
	it 'is saved with name' do
		event = Event.create name:'Happening'

		expect(event).to be_valid
		expect(Event.count).to eq(1)
	end

	it 'is not saved without name' do
		event = Event.create name:''

		expect(event).not_to be_valid
		expect(Event.count).to eq(0)
	end

	it 'has to have unique name' do
		Event.create name:'Happening'
		event = Event.create name:'Happening'

		expect(event).not_to be_valid
		expect(Event.count).to eq(1)
	end
end
