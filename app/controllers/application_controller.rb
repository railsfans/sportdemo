class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
before_filter :set_locale, :set_environmentvariable
  	protect_from_forgery
		rescue_from ActionView::MissingTemplate, :with => :rescue_record_not_found
def rescue_record_not_found       
	flash[:notice]='Invalid phone'
	logger.error("template missing")
	render :file=>"#{Rails.root}/public/500.html",  :layout=>false   
end     
 
def rescue_action_in_public(exception)
	logger.error("rescue_action_in_public executed")
	case exception
	when ActiveRecord::RecordNotFound, ActionController::RoutingError,
	ActionController::UnknownAction
		logger.error("404 displayed")
		render(:file  => "#{Rails.root}/public/404.html", :status => "404 Not Found", :layout=>false)
	else
		logger.error("500 displayed")
		render(:file  => "#{Rails.root}/public/500.html", :status => "500 Error", :layout=>false)
#       SystemNotifier.deliver_exception_notification(self, request, exception)
	end
end


  
def checkaction
	rescue_from AbstractController::ActionNotFound do |exception|
	    # use exception.path to extract the path information
	    # This does not work for partials
		flash[:notice]='Invalid phone'
		logger.error("template missing")
		render :file=>"#{Rails.root}/public/500.html",  :layout=>false
	end
end

def setlanguage
	I18n.locale=params[:language]
	cookies[:locale]=params[:language]
	params[:loginpage]=params[:loginpage] || ''
	if params[:loginpage]=='true'
		redirect_to login_path
	else
		respond_to do |format|
			format.json { render :json=>{ :success=>true, :currenturl=>$currenturl}}
		end
	end
end

def settheme
	$currenttheme=params[:theme] if ['extjs-yellow', 'extjs-default', 'extjs-pink'].include? params[:theme]
	respond_to do |format|
		format.json { render :json=>{ :success=>true, :currenttheme=>$currenttheme}}
	end
end

private
  def set_environmentvariable
	$currenturl= $currenturl || root_path
    $currenttheme = $currenttheme || "extjs-default"
  end
  def set_locale
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

def authenticate_user
	flag=false
	params[:usertype]='student'
	if params[:usertype]=='student'
		Student.all.each do |s|
  		if s.passwdstatus==false &&  (Time.now-1.hours-8.hours).to_s<s.resetpwdtime && s.passwdtoken==params[:passwordtoken]
    		flag=true
    		break
  		end
	end
	else if params[:usertype]=='teacher'
		Teacher.all.each do |s|
  			if s.passwdstatus==false &&  (Time.now-1.hours-8.hours).to_s<s.resetpwdtime && s.passwdtoken==params[:passwordtoken]
    		flag=true
    		break
  			end
		end
	else if params[:usertype]=='grademaster'
		Grademaster.all.each do |s|
  			if s.passwdstatus==false &&  (Time.now-1.hours-8.hours).to_s<s.resetpwdtime && s.passwdtoken==params[:passwordtoken]
    		flag=true
    		break
  			end
	end
	else if params[:usertype]=='supportman'
		Supportman.all.each do |s|
  			if s.passwdstatus==false &&  (Time.now-1.hours-8.hours).to_s<s.resetpwdtime && s.passwdtoken==params[:passwordtoken]
    		flag=true
    		break
  			end
		end
	else if params[:usertype]=='headmaster'
		Headmaster.all.each do |s|
  			if s.passwdstatus==false &&  (Time.now-1.hours-8.hours).to_s<s.resetpwdtime && s.passwdtoken==params[:passwordtoken]
    		flag=true
    		break
  		end
	end
	end
	end
	end
	end
	end
	flag==true ? true : access_denied
end



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
