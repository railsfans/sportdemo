class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
before_filter :set_locale
  protect_from_forgery
def setlanguage
	I18n.locale=params[:language]
	cookies[:locale]=params[:language]
	respond_to do |format|
		format.json { render :json=>{ :success=>true, :currenturl=>$currenturl}}
	end
end

private
  def set_locale
	$currenturl= $currenturl || root_path
    I18n.locale =  cookies[:locale] || setup_locale 
  end

  def setup_locale
    if logged_in?
      current_user.update_attribute(:locale=>guess_browser_language)  if current_user.locale.blank?
      return cookies[:locale] = current_user.locale
    else
      return cookies[:locale] = guess_browser_language
    end
  end

  def guess_browser_language
    request.accept_language.split(/,/).each{|language|
      if language =~ /zh/i
        return 'zh'
      else
        return I18n.default_locale
      end
    } unless request.accept_language.blank?
    return I18n.default_locale
  end
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
