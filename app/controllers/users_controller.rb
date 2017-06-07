class UsersController < ApplicationController
	before_action :restrict_to_signed_in, only: [:index, :new, :create]

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to users_path
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)

		if @user.save && @user.authenticate(params[:user][:password])
			redirect_to new_user_path
		else
			render :new
		end
	end

	private

	def user_params
		params.require(:user).permit(:username,:email,:password_digest)
		params.require(:user).permit(:username,:email,:password, :password_confirmation)
	end

end
