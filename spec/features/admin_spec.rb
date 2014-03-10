require 'spec_helper'

describe 'Event' do
	it 'can be deleted if current user is admin'
	it 'cannot be deleted if current user is not admin'
end

describe 'Game' do
	it 'can be deleted if current user is admin'
	it 'cannot be deleted if current user is not admin'
end

describe 'Tournament' do
	it 'can be deleted if current user is admin'
	it 'cannot be deleted if current user is not admin or operator'
end