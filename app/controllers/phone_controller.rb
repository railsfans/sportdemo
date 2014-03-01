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

def updatetargetdata
	params[:passwdtoken] = params[:passwdtoken] || ''
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=true
		Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).target.update_attributes(:step=>params[:step], :distance=>params[:distance], :calorie=>params[:calorie], :activetime=>params[:activetime])
	else
		flag=false
		errormessage="please send right params"
  	end
	respond_to do |format|
		if flag	
			format.json { render :json=>{ :success=>flag }}
		else
			format.json { render :json=>{ :success=>errormessage }}
		end
	end
end

def getdeviceinfo
	params[:passwdtoken]=params[:passwdtoken] || ''
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=true
	else if !params[:passwdtoken].empty? && Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=false
        message="phone token error, please login again"
	else
		flag=false 
		message="equipment haven't bound"
	end
	end
	respond_to do |format|
		if flag
			format.json { render :json=>{ :success=>flag, :battery=>Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).devices.first.battery, :lastupdate=>Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).devices.first.lastupdate.to_s.gsub(/ UTC/, ''), :deviceid=>Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).devices.first.deviceid }}
		else
			format.json { render :json=>{ :success=>message}}
		end
	end
end

def updateuserinfo
	params[:passwdtoken]=params[:passwdtoken] || ''
	params[:studentid]=params[:studentid] || ''
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=true
		if params[:studentid].empty?
			Login.getuserinfo(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).first.update_attributes(:email=>params[:email], :name=>params[:name], :sex=>params[:sex]=='male' ? true : false , :height=>params[:height], :weight=>params[:weight], :phone=>params[:phone])
		else
			Login.getuserinfo(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).first.update_attributes(:email=>params[:email], :name=>params[:name], :sex=>params[:sex]=='male' ? true : false , :height=>params[:height], :weight=>params[:weight], :phone=>params[:phone], :studentid=>params[:studentid])
		end
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
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty? && Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).hashed_password==params[:oldpasswd]
		flag=true
		Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).update_attributes(:hashed_password=>params[:newpasswd])
	else if !params[:passwdtoken].empty? && Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=false
		message="please send right passwdtoken"
	else !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty? && Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).hashed_password!=params[:oldpasswd]
		flag=false
		message="please send right passwd"
    end
	end
	respond_to do |format|
		if flag
			format.json { render :json=>{ :success=>flag }}
		else
			format.json { render :json=>{ :success=>flag, :errormessage=>message}}
		end
	end
end

def getexercisedata
	params[:date]=params[:date] || ''
    params[:passwdtoken]=params[:passwdtoken] || ''
	if !params[:date].empty? && !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken]).empty?
		flag=true
		exercisedata=Motiondata.where(:user_id=>Phonelock.where(:token=>params[:passwdtoken]).first.login_id, :user_type=>Login.find(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).usertype).where(:motiontime.lt=>Time.new(params[:date].split('-')[0],params[:date].split('-')[1],params[:date].split('-')[2]).end_of_day).where(:motiontime.gte=>Time.new(params[:date].split('-')[0],params[:date].split('-')[1],params[:date].split('-')[2]).beginning_of_day)
	else
		flag=false
		errormessage="please send right params"
	end
	respond_to do |format|
		if flag
			format.json  { render :json=> {:success=>flag, :current=>{ :step=>exercisedata.sum(:step).round(0), :distance=>exercisedata.sum(:distance).round(2), :calorie=>exercisedata.sum(:calorie).round(0), :activetime=>exercisedata.sum(:step).round(0) } } }
		else
			format.json { render :json=> {:success=>errormessage } }
		end	
	end
end

def getstationinfo
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken]).empty?
		flag=true
	else
		flag=false
		errormessage="passwdtoken error"
	end
	respond_to do |format|
		if flag
			format.json { render :json=>{:stationinfo=>Basestation.all.collect { |list| { :id=>list.code, :status=>list.status ?  'ok' : 'error', :name=>list.name, :place=>list.place, :lastupdate=>list.updated_at.to_s.split('T')[0].split('U')[0]  }}  }}
		else
			format.json { render :json=>{:errormessage=>errormessage }}
		end
	end
end

def updateteacherinfo
	params[:passwdtoken]=params[:passwdtoken] || ''
	if !params[:passwdtoken].empty? && !Phonelock.where(:token=>params[:passwdtoken],:status=>true).empty?
		flag=true
		Login.getuserinfo(Phonelock.where(:token=>params[:passwdtoken]).first.login_id).first.update_attributes(:email=>params[:email], :name=>params[:name], :sex=>params[:sex]=='male' ? true : false , :height=>params[:height], :teacherid=>params[:teacherid], :phone=>params[:phone])
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
		usertype=Login.find(Login.getuserinfo(user.first.id).first.login_id).usertype
    end
    respond_to do |format|
		if flag && usertype=="student"
			format.json { render :json=>{:usertype=>user.first.usertype, :userdata=>{:email=>Login.getuserinfo(user.first.id).first.email, :sex=>Login.getuserinfo(user.first.id).first.sex==true ? 'male' : 'female', :phone=>Login.getuserinfo(user.first.id).first.phone, :height=>Login.getuserinfo(user.first.id).first.height, :weight=>Login.getuserinfo(user.first.id).first.weight, :name=>Login.getuserinfo(user.first.id).first.name, :studentid=>Login.getuserinfo(user.first.id).first.studentid, :class=>'class 1'}, :passwdtoken=>passwdtoken, :current=>{ :step=>Motiondata.where(:user_id=>user.first.id, :user_type=>user.first.usertype).where(:motiontime.lt=>Time.now.end_of_day).where(:motiontime.gte=>Time.now.beginning_of_day).sum(:step).round(0), :distance=>Motiondata.where(:user_id=>user.first.id, :user_type=>user.first.usertype).where(:motiontime.lt=>Time.now.end_of_day).where(:motiontime.gte=>Time.now.beginning_of_day).sum(:distance).round(2), :calorie=>Motiondata.where(:user_id=>user.first.id, :user_type=>user.first.usertype).where(:motiontime.lt=>Time.now.end_of_day).where(:motiontime.gte=>Time.now.beginning_of_day).sum(:calorie).round(0), :activetime=>Motiondata.where(:user_id=>user.first.id, :user_type=>user.first.usertype).where(:motiontime.lt=>Time.now.end_of_day).where(:motiontime.gte=>Time.now.beginning_of_day).sum(:step).round(0) },:target=>{:step=>user.first.target.step.round(0), :distance=>user.first.target.distance.round(2), :calorie=>user.first.target.calorie.round(0), :activetime=>user.first.target.activetime.round(0) }} }
       	else if flag && usertype=="teacher"
#			format.json { render :json=>{:usertype=>user.first.usertype, :userdata=>{:email=>Login.getuserinfo(user.first.id).first.email, :sex=>Login.getuserinfo(user.first.id).first.sex==true ? 'male' : 'female', :name=>Login.getuserinfo(user.first.id).first.name}, :passwdtoken=>passwdtoken, :classinfo=>Login.getuserinfo(user.first.id).first.shclasses.collect { |list| { :classinfo=>{:classname=>list.name, :studentinfo=>Student.where(:shclass_id=>list.id)}}} } }
			format.json { render :json=>{:usertype=>"class"+user.first.usertype, :userdata=>{:email=>Login.getuserinfo(user.first.id).first.email, :sex=>Login.getuserinfo(user.first.id).first.sex==true ? 'male' : 'female', :name=>Login.getuserinfo(user.first.id).first.name, :class=>Login.getuserinfo(user.first.id).first.shclasses.first.name, :phone=>Login.getuserinfo(user.first.id).first.phone, :teacherid=>Login.getuserinfo(user.first.id).first.teacherid}, :passwdtoken=>passwdtoken, :studentinfo=>Student.where(:shclass_id=>Login.getuserinfo(user.first.id).first.shclasses.first.id).collect { |list| { :id=>list.studentid, :name=>list.name}} } }
		else
       		format.json	{ render :json=>{:errormessage=>message}}
       	end
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
