require 'spec_helper'

describe Game do
	it 'is saved with proper name' do
		game = Game.create name:'The Game'

		expect(game).to be_valid
		expect(Game.count).to eq(1)
	end

	it 'is not saved without name' do
		game = Game.create

		expect(game).not_to be_valid
		expect(Game.count).to eq(0)
	end

	it 'is not saved if name is taken' do
		game1 = Game.create name:'The Game'
		game2 = Game.create name:'The Game'

		expect(game2).not_to be_valid
		expect(Game.count).to eq(1)
	end

	it 'can be deleted' do
		game = Game.create name:'The Game'

		expect {
			game.delete
		}.to change{Game.count}.from(1).to(0)
	end
end