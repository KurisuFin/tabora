class User < ActiveRecord::Base

	#TODO Password things
	def self.authenticate(username)
		User.find_by(username: username)
	end
end
