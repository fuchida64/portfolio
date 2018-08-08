class UsersController < ApplicationController

	# マイページ表示
	def show
	  	@user = User.find(params[:id])
	  	@diaries = @user.diaries
	end

	# マイページ編集
	def edit
		@user = User.find(current_user.id)
	end

	# マイページ更新
	def update
		@user = User.find(current_user.id)
	    if @user.update(user_params)
	    	redirect_to user_path(@user.id)
	    else
	    	render 'edit'
	    end
	end

	# パスワード変更
	def password_edit
		@user = User.find(params[:id])
	end
	# パスワード更新
	def password_update
	    @user = User.find(params[:id])
	    if @user.update_with_password(user_params)
	      	bypass_sign_in(@user)
			flash[:notice] = "パスワードを変更しました"
			redirect_to user_path(@user.id)
	    else
	        flash[:notice] = "パスワードが正しく設定されていません"
	        redirect_to edit_password_path
	    end
	end

	def following
		@user  = User.find(params[:id])
		@users = @user.followings
		render 'show_follow'
	end

	def followers
		@user  = User.find(params[:id])
		@users = @user.followers
		render 'show_follower'
	end

	private

	def user_params
	    params.require(:user).permit(:email, :name, :profile_image, :email, :password, :password_confirmation, :current_password, :public_setting)
	end

end
