class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:username])
		if user
			session[:user_id] = user.id
			redirect_to user
		else
			render 'new'
		end
	end

	
	def destroy
		session[:user_id] = nil
		redirect_to :root
	end
end