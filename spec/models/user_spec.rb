require 'spec_helper'

describe User do
	it 'is saved with proper name' do
		user = User.create username:'Jack'

		expect(user).to be_valid
		expect(User.count).to eq(1)
	end

	it 'is not saved if username is too short' do
		user = User.create username:'Bo'

		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end

	it 'is not saved if username is already taken' do
		user1 = User.create username:'Jack'
		user2 = User.create username:'Jack'

		expect(user2).not_to be_valid
		expect(User.count).to eq(1)
	end

	it 'can be deleted' do
		user = User.create username:'Jack'

		expect {
			user.delete
		}.to change{User.count}.from(1).to(0)
	end
end