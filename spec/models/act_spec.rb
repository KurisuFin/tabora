require 'spec_helper'

describe Act do
	let!(:battle) { FactoryGirl.create :battle }

	it 'is saved with battle' do
		act = Act.create battle:battle

		expect(act).to be_valid
		expect(Act.count).to eq(1)
	end

	it 'is not saved without battle' do
		act = Act.create

		expect(act).not_to be_valid
		expect(Act.count).to eq(0)
	end

	it 'can be deleted' do
		act = Act.create battle:battle

		expect {
			act.delete
		}.to change{Act.count}.from(1).to(0)
	end

	it 'is destroyed if associated battle is destroyed' do
		act = Act.create battle:battle

		expect {
			battle.destroy
		}.to change{Act.count}.from(1).to(0)
	end
end