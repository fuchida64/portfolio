class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :password_edit, :password_update]

	def show
	  	@user = User.find(params[:id])
	  	if user_signed_in? && current_user.id == @user.id
	  		@diaries = @user.diaries.order(id: :desc)
	  	else
	  		@diaries = @user.diaries.where(inform_status: '公開').order(id: :desc)
	  	end
	end

	def favorites
		@user = User.find(params[:id])
		@favorites = @user.favorites.order(id: :desc)
	end

	def edit
		@user = User.find(current_user.id)
	end

	def update
		@user = User.find(current_user.id)
	    if @user.update(user_params)
	    	flash[:notice] = "更新されました。"
	    	redirect_to user_path(@user)
	    else
	    	render 'edit'
	    end
	end

	def destroy
		@user = User.find(current_user.id)
		if  @user.destroy
		  	flash[:notice] = "退会しました。"
		else
			flash[:alert] = "エラーが発生しました。"
		end
		redirect_to homes_path
	end

	def password_edit
		@user = User.find(current_user.id)
	end

	def password_update
	    @user = User.find(current_user.id)
	    if @user.update_with_password(user_params)
	      	bypass_sign_in(@user)
			flash[:notice] = "パスワードを変更しました。"
			redirect_to user_path(@user)
	    else
	        render 'password_edit'
	    end
	end

	def following
		@user  = User.find(params[:id])
		@users = @user.followings
		if @users.present?
			render 'show_follow'
		else
			redirect_back(fallback_location: homes_path)
		end
	end

	def followers
		@user  = User.find(params[:id])
		@users = @user.followers
		if @users.present?
			render 'show_follower'
		else
			redirect_back(fallback_location: homes_path)
		end
	end

	private

	def user_params
	    params.require(:user).permit(:email, :name, :profile_image, :email, :password, :password_confirmation, :current_password, :public_setting)
	end

end
