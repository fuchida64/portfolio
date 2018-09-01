class AdminsController < ApplicationController
	before_action :authenticate_admin!

	def user_index
		@users = User.all.order(id: :desc)
	end

	def index
		@admins = Admin.all.order(id: :desc)
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		@admin = Admin.find(params[:id])
	    if @admin.update(admin_params)
	    	flash[:notice] = "更新されました。"
	    	redirect_to admins_path
	    else
	    	render 'edit'
	    end
	end

	private

	def admin_params
	    params.require(:admin).permit(:email, :admin_name, :admin_image)
	end
end
