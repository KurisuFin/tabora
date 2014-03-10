require 'spec_helper'

describe Tournament do
	let!(:event) { FactoryGirl.create(:event) }
	let!(:game) { FactoryGirl.create(:game) }

	it 'is saved with event and game' do
		tournament = Tournament.create event:event, game:game

		expect(tournament).to be_valid
		expect(Tournament.count).to eq(1)
	end

	it 'is not saved without event' do
		tournament = Tournament.create game:game

		expect(tournament).not_to be_valid
		expect(Tournament.count).to eq(0)
	end

	it 'is not saved without game' do
		tournament = Tournament.create event:event

		expect(tournament).not_to be_valid
		expect(Tournament.count).to eq(0)
	end

	it 'has name if given' do
		tournament = Tournament.create name:'Mega Massacre!', event:event, game:game

		expect(tournament.name).to eq('Mega Massacre!')
	end

	it 'has name of game if name is not given' do
		tournament = Tournament.create event:event, game:game

		expect(tournament.name).to eq('The Game')
	end

	it 'can be deleted' do
		tournament = Tournament.create event:event, game:game

		expect {
			tournament.delete
		}.to change{Tournament.count}.from(1).to(0)
	end
end