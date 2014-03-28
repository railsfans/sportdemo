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
 		format.json { render :json=>{:totalCount=>totalcount, :gridData=>data.collect { |list| {:name=>list.name, :place=>list.place, :status=>list.status ? t(:online) : t(:offline), :name=>list.name, :ip=>list.ip, :code=>list.code, :id=>list.id, :longitude=>list.longitude, :latitude=>list.latitude } }}}
  	end
end

def basestation_add 
	Basestation.create(:place=>params[:place], :code=>params[:code], :name=>params[:name], :longitude=>params[:longitude], :latitude=>params[:latitude], :ip=>params[:ip])
   	respond_to do |format| 
		format.json { render :json=>{:success=>true }}
  	end
end

def basestation_edit
	
  	Basestation.find(params[:id]).update_attributes(:place=>params[:place], :code=>params[:code], :name=>params[:name], :longitude=>params[:longitude], :latitude=>params[:latitude], :ip=>params[:ip], :setparamsflag=>'0')
   
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
	@basestation=Basestation.find(params[:stationid])
	@basestation.update_attributes(:reqlogflag=>'0')
=begin
	count=1
	flag=true
	for i in 0..5
		sleep(1)
		count=count+1
   		if @basestation.reqlogflag=='1' then
      		break
   		end
	end
	if count>3
		flag=false
    end
=end
	sleep(3)
	respond_to do |format|
		format.json { render :json=>{:gridData=>getStationLog(params[:stationid]) }}
	end
end

def loadallteacherinfo
	respond_to do |format|
		format.json { render :json=>{ :totalCount=>Teacher.all.count, :gridData=>Teacher.all }} 
	end
end

def loadallstudentinfo
	respond_to do |format|
		format.json { render :json=>{ :totalCount=>Student.all.count, :gridData=>Student.all }} 
	end
end

def getStationLog(stationid)
	return Basestation.find(stationid)
end

def personinfo
	@user=Student.first
end

def update_managerinfo
	@success=false
	respond_to do |format|
		format.js
	end
end

def loadform
	@user=Student.first
	render :layout=>false
end

end
