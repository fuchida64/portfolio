class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :profile_image_id, :admin_name, :admin_image_id])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :name, :email, :password])
	end

	def after_sign_in_path_for(resource)
		case resource
		when User
    		user_path(current_user.id)
  		when Admin
   			admins_path
  		end
	end

	def after_sign_out_path_for(resource)
    	if resource == :admin
      		new_admin_session_path
    	else
     	 	new_user_session_path
    	end
  	end

end

