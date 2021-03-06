class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new 
		@user = User.new
	end

	def create
		@user = User.new(params_user)
		if @user.save
			log_in @user
			flash[:success] = "Welcome #{@user.email}"
			redirect_to root_path
		else
			flash[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end
	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(params_user)
			redirect_to root_path
		else
			redirect_to 'users#edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path
	end

	private

	def params_user
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
