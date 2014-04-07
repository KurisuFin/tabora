module OwnTestHelper
	def login(credentials)
		visit login_path
		fill_in 'username', with:credentials[:username]
		fill_in 'password', with:credentials[:password]
		click_button 'Login'
	end


	def create_and_login_admin
		FactoryGirl.create :user, username:'admin', admin:true

		visit login_path
		fill_in 'username', with:'admin'
		fill_in 'password', with:'secret'
		click_button 'Login'
	end


	def button(text, n)
		page.all(:button, text)[n]
	end
end