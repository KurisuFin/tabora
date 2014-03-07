class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:username])

		if user
			session[:user_id] = user.id
			redirect_to user
		else
			redirect_to :back, notice: 'No such user'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to :root
	end
end