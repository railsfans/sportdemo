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

def basestationgrid
	respond_to do |format|
		format.js
		format.html
		format.json
	end
end

def baidumap
	respond_to do |format|
		format.js
		format.html
	end
end

def googlemap
	respond_to do |format|
		format.js
		format.html
	end
end

def basestation
	data=Basestation.offset(params[:start].to_i).limit(params[:limit].to_i)
  	totalcount=Basestation.all.count
  	respond_to do |format| 
 		format.json { render :json=>{:totalCount=>totalcount, :gridData=>data.collect { |list| {:name=>list.name, :place=>list.place, :status=>list.status ? t(:working) : t(:breaking), :name=>list.name, :ip=>list.ip, :code=>list.code, :id=>list.id, :longitude=>list.longitude, :latitude=>list.latitude } }}}
  	end
end

def basestation_add 
	Basestation.create(:place=>params[:place], :status=>params[:status]==t(:working) ? true : false, :code=>params[:code], :name=>params[:name], :longitude=>params[:longitude], :latitude=>params[:latitude], :ip=>params[:ip])
   	respond_to do |format| 
		format.json { render :json=>{:success=>true }}
  	end
end

def basestation_edit
	
  	Basestation.find(params[:id]).update_attributes(:place=>params[:place], :status=>params[:status]==t(:working) ? true : false, :code=>params[:code], :name=>params[:name], :longitude=>params[:longitude], :latitude=>params[:latitude], :ip=>params[:ip], :setparamsflag=>'0')
   
	respond_to do |format| 
   		format.json { render :json=>{:success=>true, :griddata=>Basestation.all }}
  	end
end

def basestation_delete
  	Basestation.find(params[:id]).destroy
   
  	respond_to do |format| 
       	format.json { render :json=>{:success=>true }}
  	end
end

def stationlog
	Basestation.find(params[:stationid]).update_attributes(:reqlogflag=>'0')
	respond_to do |format|
		format.json { render :json=>{:gridData=>Basestation.find(params[:stationid]) }}
	end
end

end
