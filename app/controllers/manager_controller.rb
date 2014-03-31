class ManagerController < ApplicationController
layout "manager" 
before_filter :authenticate_manager
skip_before_filter  :verify_authenticity_token, :only=>[:phone_version_add, :phone_version_edit]
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

def download
	file = Dir.pwd+'/public/phoneapp/'+params[:filename]
	p file
	if File.file? file
	    send_file file,  :x_sendfile=>true, :filename => params[:filename].split('_')[1]
	else
	  render :text => "the file does not exist"
	end
end

def phone_version_add
	directory = Dir.pwd+'/public/phoneapp'
	@location=Time.now.strftime("%Y-%m-%d %H:%M:%S").split(' ').join('-')+'_'+params[:filelocation].original_filename
	path = File.join(directory,@location)
	File.open(path, "wb") { |f| f.write(params[:filelocation].read)} 
	Phonesoftlog.create(:versioncode=>params[:versioncode], :updatetime=>Time.now, :softinfo=>params[:softinfo], :applocal=>@location)
	
   	respond_to do |format| 
		format.json { render :json=>{:success=>true }, :content_type => 'text/html'}
  	end
end

def phone_version_edit
	if !params[:filelocation].nil?
	directory = Dir.pwd+'/public/phoneapp'
	@location=Time.now.strftime("%Y-%m-%d %H:%M:%S").split(' ').join('-')+'_'+params[:filelocation].original_filename
	path = File.join(directory,@location)
	File.open(path, "wb") { |f| f.write(params[:filelocation].read)} 
	removeoldfilecmd="cd "+directory+"; rm -rf "+Phonesoftlog.find(params[:id]).applocal
	p removeoldfilecmd
	system(removeoldfilecmd)
  		Phonesoftlog.find(params[:id]).update_attributes(:versioncode=>params[:versioncode], :updatetime=>Time.now, :softinfo=>params[:softinfo], :applocal=>@location)
	else
		Phonesoftlog.find(params[:id]).update_attributes(:versioncode=>params[:versioncode], :updatetime=>Time.now+8.hours, :softinfo=>params[:softinfo])
	end
   
	respond_to do |format| 
   		format.json { render :json=>{:success=>true }, :content_type => 'text/html'}
  	end
end

def phone_version_delete
	removeoldfilecmd="cd "+directory+"; rm -rf "+Phonesoftlog.find(params[:id]).applocal
	p removeoldfilecmd
	system(removeoldfilecmd)
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
 		format.json { render :json=>{:totalCount=>totalcount, :gridData=>data.collect { |list| {:name=>list.name, :updatetime=>Time.at(list.updatetime).to_s.sub('T',' ').split('+')[0], :place=>list.place, :status=>list.status ? t(:online) : t(:offline), :name=>list.name, :ip=>list.ip, :code=>list.code, :id=>list.id, :longitude=>list.longitude, :latitude=>list.latitude } }}}
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
	@basestation.update_attributes(:reqlogflag=>'0', :updatetime=>Time.now)
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
#	sleep(3)
	respond_to do |format|
		format.json { render :json=>{:gridData=>{:logcontent=>getStationLog(params[:stationid])} }}
	end
end

def phonefeedback
	@feedback=Softfeedback.where(:version=>params[:version])
	respond_to do |format|
		format.json { render :json=>@feedback }
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
	count=[]
	Basestation.find(stationid).logcontent.split(',').each do |i|
		count<<i
	end
	log=t('reconnect count')+count[0]+'  '+t('watchreset count')+count[1]+'  '+t('hardfaultreset count')+count[2]
	return log
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
