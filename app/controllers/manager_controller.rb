class ManagerController < ApplicationController
layout "manager" 
before_filter :authenticate_manager
def phonegrid
	respond_to do |format|
		format.js
		format.html
		format.json
	end
end
def phonesoftlog
	data=Phonesoftlog.offset(params[:start].to_i).limit(params[:limit].to_i)
  	totalcount=Phonesoftlog.all.count
  	respond_to do |format| 
 		format.json { render :json=>{:totalCount=>totalcount, :gridData=>data }}
  	end
end

def phone_version_add 
	Phonesoftlog.create(:versioncode=>params[:versioncode], :updatetime=>Time.now, :softinfo=>params[:softinfo])
   	respond_to do |format| 
		format.json { render :json=>{:success=>true }}
  	end
end

def phone_version_edit
  	Phonesoftlog.find(params[:id]).update_attributes(:versioncode=>params[:versioncode], :updatetime=>Time.now, :softinfo=>params[:softinfo])
   
	respond_to do |format| 
   		format.json { render :json=>{:success=>true }}
  	end
end

def phone_version_delete
  	Phonesoftlog.find(params[:id]).destroy
   
  	respond_to do |format| 
       	format.json { render :json=>{:success=>true }}
  	end
end

end
