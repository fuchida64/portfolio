class UsersController < ApplicationController

	def show
	  	@user = User.find(current_user.id)
	end

	def edit
		@user = User.find(current_user.id)
	end

	def update
		@user = User.find(current_user.id)
	    if @user.update(user_params)
	    	redirect_to user_path(@user.id)
	    else
	    	render 'edit'
	    end
	end

	private

	def user_params
	    params.require(:user).permit(:email, :name, :profile_image)
	end

end
