module OwnTestHelper
	def login(credentials)
		visit login_path
		fill_in 'username', with:credentials[:username]
		click_button 'Login'
	end

	def p
		save_and_open_page
	end
end