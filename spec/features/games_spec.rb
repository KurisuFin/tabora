require 'spec_helper'

describe 'Game' do
	let!(:game1) { FactoryGirl.create :game, name:'The Game' }
	let!(:game2) { FactoryGirl.create :game, name:'The Peli' }


	# INDEX
	it 'is listed on index page' do
		visit games_path

		expect(page).to have_content('The Game')
		expect(page).to have_content('The Peli')
	end


	# SHOW
	it 'has own page with title' do
		visit game_path(game1)

		expect(page).to have_content 'The Game'
		expect(page).not_to have_content 'The Peli'
	end

	it 'can be visited from index page' do
		visit games_path
		click_link 'The Game'

		expect(page).to have_content('The Game')
		expect(page).not_to have_content('The Peli')
	end


	# NEW
	it 'is saved with valid name' do
		visit new_game_path
		fill_in 'game_name', with:'New game'

		expect {
			click_button 'Create Game'
		}.to change{Game.count}.from(2).to(3)
	end

	it 'is not saved without name' do
		visit new_game_path
		click_button 'Create Game'

		expect(Game.count).to eq(2)
		expect(page).to have_content 'Name can\'t be blank'
		end

	it 'is not saved if name is taken' do
		visit new_game_path
		fill_in 'game_name', with:'The Game'
		click_button 'Create Game'

		expect(Game.count).to eq(2)
		expect(page).to have_content 'Name has already been taken'
	end

	# EDIT
	it 'can be edited and is updated with valid name' do
		visit edit_game_path(game1)
		fill_in 'game_name', with:'New name'
		click_button 'Update Game'

		expect(page).to have_content 'New name'
		expect(page).not_to have_content 'The Game'
	end

	it 'is not updated without name' do
		visit edit_game_path(game1)
		fill_in 'game_name', with: ''
		click_button 'Update Game'

		expect(page).to have_content 'Name can\'t be blank'
	end

	it 'is not updated if name is taken' do
		visit edit_game_path(game1)
		fill_in 'game_name', with: 'The Peli'
		click_button 'Update Game'

		expect(page).to have_content 'Name has already been taken'
	end
end