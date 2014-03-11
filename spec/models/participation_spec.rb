require 'spec_helper'

describe Participation do
	let!(:user) { FactoryGirl.create :user }
	let!(:tournament) { FactoryGirl.create :tournament }

	it 'is saved with user and tournament' do
		participation = Participation.create user:user, tournament:tournament

		expect(participation).to be_valid
		expect(Participation.count).to eq(1)
	end

	it 'is not saved without user' do
		participation = Participation.create tournament:tournament

		expect(participation).not_to be_valid
		expect(Participation.count).to eq(0)
	end

	it 'is not saved without tournament' do
		participation = Participation.create user:user, tournament:nil

		expect(participation).not_to be_valid
		expect(Participation.count).to eq(0)
	end

	it 'can be deleted' do
		participation = Participation.create user:user, tournament:tournament

		expect {
			participation.delete
		}.to change{Participation.count}.from(1).to(0)
	end

	it 'can be created only once for one user to one tournament' do
		participation1 = Participation.create user:user, tournament:tournament
		participation2 = Participation.create user:user, tournament:tournament

		expect(participation1).to  be_valid
		expect(Participation.count).to eq(1)
	end

	it 'can be created to one user for every tournament' do
		another_tournament = FactoryGirl.create :tournament
		participation1 = Participation.create user:user, tournament:tournament
		participation2 = Participation.create user:user, tournament:another_tournament

		expect(participation1).to be_valid
		expect(participation2).to be_valid
		expect(Participation.count).to eq(2)
	end

	it 'can be created for every user to one tournament' do
		another_user = FactoryGirl.create :user
		participation1 = Participation.create user:user, tournament:tournament
		participation2 = Participation.create user:another_user, tournament:tournament

		expect(participation1).to be_valid
		expect(participation2).to be_valid
		expect(Participation.count).to eq(2)
	end
end