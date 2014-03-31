require 'spec_helper'
include OwnTestHelper

describe 'Battle' do
	let!(:tournament) { FactoryGirl.create :tournament }

	it 'is created when tournament starts with players' do
		FactoryGirl.create :participation, tournament:tournament
		FactoryGirl.create :participation, tournament:tournament

		create_and_login_admin
		visit tournament_path(tournament)

		expect {
			click_button 'Launch tournament'
		}.to change{Battle.count}.from(0).to(1)
	end


	describe 'in ongoing tournament' do
		before :each do
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament
			FactoryGirl.create :participation, tournament:tournament

			create_and_login_admin
			visit tournament_path(tournament)
			click_button 'Launch tournament'
		end

		it 'sets winner to postbattle' do
			button('+', 0).click
			button('Finish', 0).click

			expect(page).not_to have_content 'Winner of Battle #1'
		end


		it 'cannot be finished if players are tied' do
			button('Finish', 0).click

			expect(page).to have_content 'Winner of Battle #1'
			expect(page).to have_content 'Winner of Battle #2'
		end
	end
end