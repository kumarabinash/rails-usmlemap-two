class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  # Next lines are from devise documentation to make it work!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  	def configure_permitted_parameters
  		registration_params = [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation]
	    # devise_parameter_sanitizer.for(:sign_up) << :username
	    if params[:action] == 'update'
	      devise_parameter_sanitizer.for(:account_update) { 
	        |u| u.permit(registration_params << :current_password)
	      }
	    elsif params[:action] == 'create'
	      devise_parameter_sanitizer.for(:sign_up) { 
	        |u| u.permit(registration_params) 
	      }
	    end
	  end
end
