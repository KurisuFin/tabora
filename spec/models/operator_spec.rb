require 'spec_helper'

describe Operator do
	let!(:user) { FactoryGirl.create :user }
	let!(:event) { FactoryGirl.create :event }

	it 'is saved with user and event' do
		operator = Operator.create user:user, event:event

		expect(operator).to be_valid
		expect(Operator.count).to eq(1)
	end

	it 'is not saved without user' do
		operator = Operator.create event:event

		expect(operator).not_to be_valid
		expect(Operator.count).to eq(0)
	end

	it 'is not saved without event' do
		operator = Operator.create user:user

		expect(operator).not_to be_valid
		expect(Operator.count).to eq(0)
	end

	it 'can be created only once for one user to one event' do
		operator1 = Operator.create user:user, event:event
		operator2 = Operator.create user:user, event:event

		expect(operator1).to be_valid
		expect(operator2).not_to be_valid
		expect(Operator.count).to eq(1)
	end

	it 'can be created to one user for every event' do
		another_event = FactoryGirl.create :event
		event1 = Operator.create user:user, event:event
		event2 = Operator.create user:user, event:another_event

		expect(event1).to be_valid
		expect(event2).to be_valid
		expect(Operator.count).to eq(2)
	end

	it 'can be created for every user to one event' do
		another_user = FactoryGirl.create :user
		event1 = Operator.create user:user, event:event
		event2 = Operator.create user:another_user, event:event

		expect(event1).to be_valid
		expect(event2).to be_valid
		expect(Operator.count).to eq(2)
	end

	it 'can be deleted' do
		operator = Operator.create user:user, event:event

		expect {
			operator.delete
		}.to change{Operator.count}.from(1).to(0)
	end
end