require 'spec_helper'
include OwnTestHelper

describe 'User' do
	let!(:user) { FactoryGirl.create :user, username:'Jack' }
	let!(:event) { FactoryGirl.create :event, name:'Happening' }
	let!(:game1) { FactoryGirl.create :game, name:'The Game' }
	let!(:game2) { FactoryGirl.create :game, name:'The Peli' }
	let!(:tournament1) { FactoryGirl.create :tournament, event:event, game:game1 }
	let!(:tournament2) { FactoryGirl.create :tournament, event:event, game:game2 }
	let!(:participation) { FactoryGirl.create :participation, user:user, tournament:tournament1 }

	describe 'when logged in' do
		before :each do
			login username:'Jack'
		end

		it 'can join tournament' do
			visit tournament_path(tournament2)

			expect {
				click_button 'Join'
			}.to change{Participation.count}.from(1).to(2)
			expect(page).to have_button 'Leave'
			expect(page).not_to have_button 'Join'
		end

		it 'can leave tournament' do
			visit tournament_path(tournament1)

			expect {
				click_button 'Leave'
			}.to change{Participation.count}.from(1).to(0)
			expect(page).to have_button 'Join'
			expect(page).not_to have_button 'Leave'
		end
	end
end