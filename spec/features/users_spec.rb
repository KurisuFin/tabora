require 'spec_helper'
include OwnTestHelper

describe 'User' do
	let!(:user) { FactoryGirl.create :user, username:'Jack' }


	describe 'when not logged in' do
		it 'can sign up with proper username' do
			visit signup_path
			fill_in 'user_username', with:'Tina'

			expect {
				click_button 'Create User'
			}.to change{User.count}.from(1).to(2)
		end

		it 'cannot sign up if username is too short' do
			visit signup_path
			fill_in 'user_username', with:'Bo'
			click_button 'Create User'

			expect(User.count).to eq(1)
			expect(page).to have_content 'Username is too short'
		end

		it 'cannot sign up if username is taken' do
			visit signup_path
			fill_in 'user_username', with:'Jack'
			click_button 'Create User'

			expect(User.count).to eq(1)
			expect(page).to have_content 'Username has already been taken'
		end

		it 'can login' do
			visit login_path
			fill_in 'username', with:'Jack'
			click_button 'Login'

			expect(page).to have_content 'Jack'
			expect(page).to have_content 'Logout'
		end

		it 'cannot login with unexisting username' do
			visit login_path
			fill_in 'username', with:'BobTheBuilder'
			click_button 'Login'

			expect(page).to have_content 'No such user'
		end
	end


	describe 'when logged in' do
		before :each do
			login username:'Jack'
		end

		it 'can logout' do
			visit root_path
			click_link 'Logout'

			expect(page).to have_content 'Sign up'
			expect(page).to have_content 'Login'
			expect(page).not_to have_content 'Jack'
		end

		it 'can view own page' do
			visit user_path(user)

			expect(page).to have_content 'Jack'
		end

		it 'can update own information' do
			visit edit_user_path(user)
			fill_in 'user_username', with:'Bob'
			click_button 'Update User'

			expect(page).to have_content 'Bob'
			expect(page).not_to have_content 'Jack'
		end

		it 'cannot update own information if name is too short' do
			visit edit_user_path(user)
			fill_in 'user_username', with:'Bo'
			click_button 'Update User'

			expect(page).to have_content 'Username is too short'
		end

		it 'cannot update own information if name is taken' do
			FactoryGirl.create(:user, username:'Bob')
			visit edit_user_path(user)
			fill_in 'user_username', with:'Bob'
			click_button 'Update User'

			expect(page).to have_content 'Username has already been taken'
		end
	end
end