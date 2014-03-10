module OwnTestHelper
	def login(credentials)
		visit login_path
		fill_in 'username', with:credentials[:username]
		click_button 'Login'
	end
end