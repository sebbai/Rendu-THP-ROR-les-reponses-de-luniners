class SessionsController < ApplicationController
	


	def new 
		
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			flash[:success] = "Welcome #{user.email}, you are login"
			log_in user
			redirect_to user
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end



	private

	def params_session
		params.require(:session).permit(:email, :password,)
	end
end
