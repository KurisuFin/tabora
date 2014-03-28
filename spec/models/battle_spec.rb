require 'spec_helper'

describe Battle do
	let!(:tournament) { FactoryGirl.create :tournament }

	it 'is saved with tournament' do
		battle = Battle.create tournament:tournament

		expect(battle).to be_valid
		expect(Battle.count).to eq(1)
	end

	it 'is not saved without tournament' do
		battle = Battle.create

		expect(battle).not_to be_valid
		expect(Battle.count).to eq(0)
	end

	it 'can be deleted' do
		battle = Battle.create tournament:tournament

		expect {
			battle.delete
		}.to change{Battle.count}.from(1).to(0)
	end

	it 'is destroyed if associated tournament is destroyed' do
		battle = Battle.create tournament:tournament

		expect {
			tournament.destroy
		}.to change{Battle.count}.from(1).to(0)
	end


	it 'postbattle count is updated if postbattle is destroyed' do
		battle1 = Battle.create tournament:tournament
		battle2 = Battle.create tournament:tournament

		battle1.postbattles.push battle2

		expect {
			battle2.destroy
		}.to change{battle1.postbattles.count}.from(1).to(0)
	end


	it 'prebattle count is updated if prebattle is destroyed' do
		battle1 = Battle.create tournament:tournament
		battle2 = Battle.create tournament:tournament

		battle1.postbattles.push battle2

		expect {
			battle1.destroy
		}.to change{battle2.prebattles.count}.from(1).to(0)
	end
end