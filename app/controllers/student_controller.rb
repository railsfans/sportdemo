class StudentController < ApplicationController
layout "student" 
before_filter :authenticate_student
def historydata
	@historydata=Motiondata.all.limit(params[:limit].to_i).offset(params[:start].to_i)
	@count=Motiondata.all.count
    respond_to do |format|
    	 format.json { render :json=>{ :gridData=>@historydata, :totalCount=>@count }}
         format.html
         format.js
 	end
	p request.original_url
#	render :layout => false
end
def personinfo
	 
end
def datagraph
	respond_to do |format|
         format.html
         format.js
 	end
end
def rank
	
end
def feedback
	 
end
def changepersoninfo
	Student.find(params[:user_id]).update_attributes(:name=>params[:name], :email=>params[:email], :height=>params[:height], :weight=>params[:weight], :sex=>params[:sex])
	respond_to do |format|
		format.json { render :json=>{ :success=>true } }
    end
end
def loaddata 
    @data=[]
    @totaldata=[]
    @items=['step', 'distance', 'calorie']

    [:step, :distance, :calorie].each do |item|
    	(0..6).each do |i|
    		sum=0
			sum+=Motiondata.where(:user_type=>'student', :user_id=>current_user.id).where(:motiontime.lt=>Time.now.end_of_day-i.days).where(:motiontime.gte=>Time.now.beginning_of_day-i.days).sum(item) 
			@data<<sum
 		end
    	@totaldata<<@data
		@data=[]           
    end
	respond_to do |format|
        format.json { render :json=>{ :data=>@totaldata, :items=>@items} }
	end
end
def search
	params[:begintime]= params[:begintime] || ''
    params[:endtime]= params[:endtime] || ''
    degree=(Time.new(params[:endtime].split('-')[0].to_i,params[:endtime].split('-')[1].to_i,params[:endtime].split('-')[2].to_i)-Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i))/1.day
	if degree==0
		count=24
		rate=0
	else if degree >0 && degree <31
		count=degree+1
		rate=1
	else if degree >=31 && degree < 365
		count=degree/7+1
		rate=7
	else 
		count=degree/30+1
		rate=30
	end
	end
 	end
	@data=[]
	@totaldata=[]
	@items=['step', 'distance', 'calorie']
	if rate!=0
		[:step, :distance, :calorie].each do |item|
    		(1..count).each do |i|
    			sum=0
				sum+=Motiondata.where(:user_type=>'student', :user_id=>current_user.id).where(:motiontime.lt=>Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i)+i.day*rate).where(:motiontime.gte=>Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i)+(i.day-1.day)*rate).sum(item) 
				@data<<sum
 			end
    		@totaldata<<@data
			@data=[]           
    	end
	else
    	[:step, :distance, :calorie].each do |item|
    		(1..count).each do |i|
    			sum=0
				sum+=Motiondata.where(:user_type=>'student', :user_id=>current_user.id).where(:motiontime.gte=>Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i,i-1,0,0)).where(:motiontime.lt=>Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i,i-1,59,59)).sum(item) 
				@data<<sum
 			end
    		@totaldata<<@data
			@data=[]           
    	end   
	end
	respond_to do |format|
		format.json { render :json=>{ :totaldata=>@totaldata, :rate=>rate  }}
	end
end

end
