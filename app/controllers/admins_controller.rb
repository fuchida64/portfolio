class AdminsController < ApplicationController

	def user_index
		@users = User.all
	end

	def index
		@admins = Admin.all
	end

	def show
		@admin = Admin.find(params[:id])
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		@admin = Admin.find(params[:id])
	    if @admin.update(admin_params)
	    	redirect_to admin_path(@admin.id)
	    else
	    	render 'edit'
	    end
	end

	private

	def admin_params
	    params.require(:admin).permit(:email, :admin_name, :admin_image)
	end
end
