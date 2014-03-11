require 'spec_helper'

describe User do
	it 'is saved with proper name' do
		user = User.create username:'Jack'

		expect(user).to be_valid
		expect(User.count).to eq(1)
	end

	it 'is not saved if username is too short' do
		user = User.create username:'Bo'

		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end

	it 'is not saved if username is already taken' do
		user1 = User.create username:'Jack'
		user2 = User.create username:'Jack'

		expect(user2).not_to be_valid
		expect(User.count).to eq(1)
	end

	it 'can be deleted' do
		user = User.create username:'Jack'

		expect {
			user.delete
		}.to change{User.count}.from(1).to(0)
	end

	describe 'method' do
		let!(:user) { FactoryGirl.create :user }
		let!(:event) { FactoryGirl.create :event}
		let!(:tournament) { FactoryGirl.create :tournament, event:event }

		it 'is_operator_of(event) returns true if user is operator of event' do
			FactoryGirl.create :operator, user:user, event:event

			expect(user.is_operator_of event).to be(true)
		end

		it 'is_operator_of(event) returns false if user in not operator of event' do
			expect(user.is_operator_of event).to be(false)
		end

		it 'is_participating_of(tournament) returns true if user is participant of tournament' do
			FactoryGirl.create :participation, user:user, tournament:tournament

			expect(user.is_participant_of tournament).to be(true)
		end

		it 'is_participating_of(tournament) returns false if user is not participant of tournament' do
			expect(user.is_participant_of tournament).to be(false)
		end

	end
end