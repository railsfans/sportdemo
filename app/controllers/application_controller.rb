class ApplicationController < ActionController::Base
  # reset captcha code after each request for security

  protect_from_forgery

protected
def current_user
	return unless session[:user_id]
	@current_user ||= Login.find_by_id(session[:user_id])
end
 
helper_method :current_user
def authenticate
	logged_in? ? true : access_denied
end
 
def authenticate_student
	logged_in? && current_user.usertype=='student' ? true : access_denied
end

def authenticate_teacher
	logged_in? && current_user.usertype=='teacher' ? true : access_denied
end

def authenticate_manager
	logged_in? && current_user.usertype=='manager' ? true : access_denied
end

def logged_in?
	current_user.is_a? Login
end 
 
helper_method :logged_in? 
def access_denied 
	redirect_to login_path, :notice => "Please log in to continue" 
 	return false 
end

end
