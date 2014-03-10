require 'spec_helper'

describe Participation do
	let!(:user) { FactoryGirl.create :user }
	let!(:tournament) { FactoryGirl.create :tournament }

	it 'is saved with user and tournament' do
		participation = Participation.create user:user, tournament:tournament

		expect(participation).to eq(Participation.first)
		expect(Participation.count).to eq(1)
	end

	it 'is not saved without user' do
		participation = Participation.create tournament:tournament

		expect(participation).not_to be_valid
		expect(Participation.count).to eq(0)
	end

	it 'is not saved without tournament' do
		participation = Participation.create user:user

		expect(participation).not_to be_valid
		expect(Participation.count).to eq(0)
	end

	it 'can be deleted' do
		participation = Participation.create user:user, tournament:tournament

		expect {
			participation.delete
		}.to change{Participation.count}.from(1).to(0)
	end

	it 'DERP' do
		participation1 = Participation.create user:user, tournament:tournament
		participation2 = Participation.create user:user, tournament:tournament

		expect(participation2).not_to be_valid
		expect(Participation.count).to eq(1)
	end
end