class PhoneController < ApplicationController
def servicestatus
	@version=Phonesoftlog.last.versioncode
	respond_to do |format|
		format.json { render :json=>{ :versionCode=>@version }}
	end
end

def initdatabase 
	if !Phoneinfo.create(:SDK=>params[:SDK], :versionCode=>params[:versionCode], :model=>params[:model], :deviceID=>params[:deviceID]).id.nil?
		flag=true
	else
		flag=false
		message='create phone info failure'
	end
  	respond_to do |format|
		if flag
       		format.json { render :json=>{:success=>flag }}
       	else
       		format.json { render :json=>{ :errormessage=>message}}
       	end
	end
end

def phoneinfo
	@phoneinfo=Phoneinfo.all
  	respond_to do |format| 
		format.json { render :json=>{:phoneinfo=>@phoneinfo }}
  	end
end

def delphoneinfo
	Phoneinfo.all.each do |s|
		s.destroy
 	end
	respond_to do |format| 
 		format.json { render :json=>{:success=>true }}
  	end
end
  
def phonegrid
  	respond_to do |format| 
		format.js
	end
end

def getversioninfo
   	params[:versioncode]=params[:versioncode] || ''
   	if !params[:versioncode].empty?
		@versioninfo=Phonesoftlog.where(:versioncode=>params[:versioncode]).first
	   	hashcontent={}
	   	if !@versioninfo.nil?
	   		flag=true
	   		@versioncontent=[]
	   		@versioninfo.softinfo.gsub(/\n+/,'$').split('$').each_with_index do |item, index|
	      		hashcontent['id']=index+1
	      		hashcontent['item']=item
	      		@versioncontent<<hashcontent
	      		hashcontent={}
			end
		else
			flag=false
		end
   else
        flag=true
        hashcontent={}
        @versioninfo=Phonesoftlog.last
        @versioncontent=[]
	   	@versioninfo.softinfo.gsub(/\n+/,'$').split('$').each_with_index do |item, index|
			hashcontent['id']=index+1
	  		hashcontent['item']=item
	  		@versioncontent<<hashcontent
	   		hashcontent={}
		end
   end
   respond_to do |format|
		if flag
      		format.json { render :json=>{ :versioncode=>@versioninfo.versioncode, :content=>@versioncontent }}
      	else
      		format.json { render :json=>{ :errormessage=>'no version available' }}
      	end
   end
end 

def updateuserinfo
	params[:passwdtoken]=params[:passwdtoken] || ''
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=true
		Login.getuserinfo(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).first.update_attributes(:email=>params[:email], :name=>params[:name], :sex=>params[:sex]=='male' ? true : false , :height=>params[:height], :weight=>params[:weight], :phone=>params[:phone])
	else
		flag=false
		message="please send passwdtoken or passwdtoken wrong"
	end
	respond_to do |format|
		if flag
			format.json { render :json=>{ :success=>flag }}
		else
			format.json { render :json=>{ :success=>flag, :errormessage=>message}}
		end
	end
end

def resetpassword
	params[:passwdtoken]=params[:passwdtoken] || ''
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty? && Login.getuserinfo(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).first.passwd==params[:oldpasswd]
		flag=true
		Login.getuserinfo(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).first.update_attributes(:hashed_password=>params[:newpasswd])
	else
		flag=false
		message="please send right passwd and passwdtoken"
	end
	respond_to do |format|
		if flag
			format.json { render :json=>{ :success=>flag }}
		else
			format.json { render :json=>{ :success=>flag, :errormessage=>message}}
		end
	end
end

  
def login 
	user = Login.phone_authenticate(params[:username], params[:password]) 
    if user.empty? 
		flag=false
		message="password or username error"
    else
    	flag=true
     	passwdtoken=Login.newpass(12)
		phonelock=Phonelock.where(:login_id=>user.first.id).first_or_create(:login_id=>user.first.id, :status=>true, :token=>passwdtoken)
		phonelock.update_attributes(:login_id=>user.first.id, :status=>true, :token=>passwdtoken)
    end
    respond_to do |format|
		if flag
			format.json { render :json=>{:usertype=>user.first.usertype, :userdata=>{:email=>Login.getuserinfo(user.first.id).first.email, :sex=>Login.getuserinfo(user.first.id).first.sex==true ? 'male' : 'female', :phone=>Login.getuserinfo(user.first.id).first.phone, :height=>Login.getuserinfo(user.first.id).first.height, :weight=>Login.getuserinfo(user.first.id).first.weight, :name=>Login.getuserinfo(user.first.id).first.name, :studentid=>Login.getuserinfo(user.first.id).first.studentid, :class=>'class 1'}, :passwdtoken=>passwdtoken} }
       	else
       		format.json	{ render :json=>{:errormessage=>message}}
       	end
	end
end

def logout
	params[:passwordtoken]=params[:passwordtoken] || ''
	if params[:passwordtoken].nil? || Phonelock.where(:token=>params[:passwordtoken]).empty?
		errormessage="must send passwordtoken to server or passwordtoken error"
		flag=false
  	else
		flag=true
		Phonelock.where(:token=>params[:passwordtoken]).first.update_attributes(:token=>'', :status=>false)
	end
	respond_to do |format|
		if flag
			format.json { render :json=>{ :suceess=>true }}
		else
			format.json { render :json=>{ :errormessage=>errormessage }}
		end
	end
end
end
