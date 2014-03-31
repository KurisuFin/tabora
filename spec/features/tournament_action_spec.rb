require 'spec_helper'
include OwnTestHelper

describe 'Tournament' do
	let!(:tournament) { FactoryGirl.create :tournament }

	before :each do
		create_and_login_admin
	end

	it 'has three phases' do
		visit tournament_path(tournament)

		expect(page).to have_content 'Phase: enroll'
		click_button 'Launch tournament'
		expect(page).to have_content 'Phase: ongoing'
		click_button 'End tournament'
		expect(page).to have_content 'Phase: ended'
	end


	describe 'when launched' do
		it 'with two participants creates one battle' do
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament
			visit tournament_path(tournament)

			expect {
				click_button 'Launch tournament'
			}.to change{Battle.count}.from(0).to(1)

			expect(page).to have_content 'Phase: ongoing'
			expect(page).to have_content 'Battle #1'
		end

		it 'with four participants creates two prebattles and one postbattle' do
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament
			visit tournament_path(tournament)

			expect {
				click_button 'Launch tournament'
			}.to change{Battle.count}.from(0).to(3)

			expect(page).to have_content 'Phase: ongoing'
			expect(page).to have_content 'Battle #1'
			expect(page).to have_content 'Battle #2'
			expect(page).to have_content 'Battle #3'
			expect(page).to have_content 'Winner of Battle #1'
			expect(page).to have_content 'Winner of Battle #2'
		end
	end
end