class SessionsController < ApplicationController
 include SimpleCaptcha::ControllerHelpers
layout "login", :except => :editpassword
 before_filter :authenticate_user, :only=>:resetpasswd
def routeerror
	render '/public/404.html'
end
def resetpasswd
	
	params[:passwordtoken]=params[:passwordtoken] || ''
	params[:usertype]=params[:usertype] || ''
  	@passwordtoken=params[:passwordtoken]
	@usertype='student'
	render layout: "modifypassword"
end

def editpassword
  	if params[:usertype]=='student'
    	login_id=Student.where(:passwdtoken=>params[:passwordtoken]).first.login_id
    	Student.where(:passwdtoken=>params[:passwordtoken]).first.update_attributes(:passwdtoken=>Login.newpass(12), :resetpwdtime=>Time.now, :passwdstatus=>true)
   
  	else if params[:usertype]=='teacher'
    	login_id=Teacher.where(:passwdtoken=>params[:passwordtoken]).first.login_id
    	Teacher.where(:passwdtoken=>params[:passwordtoken]).first.update_attributes(:passwdtoken=>Login.newpass(12), :resetpwdtime=>Time.now, :passwdstatus=>true)
    
  	else if params[:usertype]=='headmaster'
   		login_id=Headmaster.where(:passwdtoken=>params[:passwordtoken]).first.login_id
   		Headmaster.where(:passwdtoken=>params[:passwordtoken]).first.update_attributes(:passwdtoken=>Login.newpass(12), :resetpwdtime=>Time.now, :passwdstatus=>true)
  
  	else if params[:usertype]=='grademaster'
    	login_id=Grademaster.where(:passwdtoken=>params[:passwordtoken]).first.login_id
    	Grademaster.where(:passwdtoken=>params[:passwordtoken]).first.update_attributes(:passwdtoken=>Login.newpass(12), :resetpwdtime=>Time.now, :passwdstatus=>true)
   
  	else if params[:usertype]=='supportman'
   		login_id=Supportman.where(:passwdtoken=>params[:passwordtoken]).first.login_id
   		Supportman.where(:passwdtoken=>params[:passwordtoken]).first.update_attributes(:passwdtoken=>Login.newpass(12), :resetpwdtime=>Time.now, :passwdstatus=>true)
 
  	end
  	end
  	end
  	end
  	end
      	Login.find(login_id).update_attributes(:password=>params[:password])
     	redirect_to root_path
end

def sendemail
	passwordtoken=Login.newpass(12)
	flag=false
	if !Student.where(:email=>params[:email]).empty?
		flag=true
		Student.where(:email=>params[:email]).first.update_attributes(:resetpwdtime=>Time.now, :passwdtoken=>passwordtoken, :passwdstatus=>false) 
		Notifier.confirm(params[:email], passwordtoken).deliver
	end
	respond_to do |format|
  		format.json { render :json=>{:success=>flag}}
	end
end

def refreshcode
	respond_to do |format|
		format.html
	end
end

def create 
#	if user = Login.authenticate(params[:username], params[:password], params[:usertype]) 
#		session[:user_id] = user.id 
#		redirect_to root_path, :notice => "Logged in successfully" 
#	else 
#		flash.now[:alert] = "Invalid login/password combination" 
#		render :action => 'new' 
#	end
#	params[:logintype]= params[:logintype] || 'pc'
#	if params[:logintype]=='pc'
	errormessage=''
	if simple_captcha_valid?
		if  Login.authenticate(params[:username], params[:password], params[:usertype])
	        user = Login.authenticate(params[:username], params[:password], params[:usertype])
	        session[:user_id] = user.id 
			flag=true
			type=user.usertype
	    else
	  		flag=false
			type=''
			errormessage='password wrong'
		end
	else
  		flag=false
		type=''
		errormessage='checkcode wrong'
	end
	    
#	else if params[:logintype]='phone'
#		if Login.phoneauthenticate(params[:username], params[:password])
#			flag=true
#    		user=Login.phoneauthenticate(params[:username], params[:password])
#    		passwdtoken=Login.newpass(12)
#			Phonelock.where(:user_id=>user.id).first_or_create(:user_id=>user.id, :status=>true, :token=>passwdtoken)	
#		else
#			flag=false
#			message="password or username error"
#		end
#	end
	respond_to do |format|
#		if params[:logintype]=='pc'
			format.json { render :json=>{:success=>flag, :type=>type, :errormessage=>errormessage} }
#		else if params[:logintype]='phone'
#			if flag
#       			format.json { render :json=>{ :usertype=>user.usertype, :userdata=>Login.getuserinfo(user.id), :token=>passwdtoken} }
#       		else
#       			format.json{ render :json=>{:errormessage=>message}}
#       		end
#		end
	end
end

def destroy 
#	params[:logintype]= params[:logintype] || 'pc'
#	if params[:logintype]=='pc'
		reset_session 
		redirect_to login_path, :notice => "You successfully logged out" 
#	else if params[:logintype]='phone'
#		Phonelock.where(:token=>params[:passwordtoken).first.update_attributes(:token=>'', :status=>false)
#		format.json{ render :json=>{:message=>"success logout"}}
#	end
end 
 
end
