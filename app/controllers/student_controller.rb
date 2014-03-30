class StudentController < ApplicationController
layout "student" 
before_filter :authenticate_student
def testsort
#	 render :layout => false     
end

def loadjs
	respond_to do |format|
		format.js
	end
end
def historydata
	@historydata=Motiondata.all.limit(params[:limit].to_i).offset(params[:start].to_i)
	@count=Motiondata.all.count
    respond_to do |format|
    	 format.json { render :json=>{ :gridData=>@historydata, :totalCount=>@count }}
         format.html
         format.js
 	end
	$currenturl=request.original_url
	p $currenturl
#	render :layout => false
end
def personinfo
	$currenturl=request.original_url
	p $currenturl
	respond_to do |format|
         format.html
         format.js
 	end
end
def datagraph
	$currenturl=request.original_url
	p $currenturl
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

def loadfeedback
	respond_to do |format|
		format.js
	end
end

def loaddata 
=begin
    @data=[]
    @totaldata=[]
    @items=[t(:step), t(:distance), t(:calorie)]

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
=end
	@data=[]
    @totaldata=[]
    @items=[t(:sedentary), t(:light), t(:moderate), t(:high), t(:vigorous)]
	
    [:sedentary, :light, :moderate, :high, :vigorous].each do |item|
    	(0..6).each do |i|
    		sum=0
			@time_begin=(Time.now.beginning_of_day-7.days+i.days).to_s.split(' ')[0]+' '+(Time.now.beginning_of_day-7.days+i.days).to_s.split(' ')[1]
			@time_end=(Time.now.end_of_day-7.days+i.days).to_s.split(' ')[0]+' '+(Time.now.end_of_day-7.days+i.days).to_s.split(' ')[1]
			sum+=Motiondata.where(:user_type=>'student', :user_id=>current_user.id).where(:motiontime.lte=>@time_end).where(:motiontime.gte=>@time_begin).sum(item) 
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
=begin
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
=end
	@items=[t(:sedentary), t(:light), t(:moderate), t(:high), t(:vigorous)]
	if rate!=0
		[:sedentary, :light, :moderate, :high, :vigorous].each do |item|
    		(1..count).each do |i|
    			sum=0
				@begintime=(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i)+(i.day-1.day)*rate).to_s.split(' ')[0]+' '+(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i)+(i.day-1.day)*rate).to_s.split(' ')[1]
				@endtime=(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i)+i.day*rate).to_s.split(' ')[0]+' '+(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i)+i.day*rate).to_s.split(' ')[1]
				sum+=Motiondata.where(:user_type=>'student', :user_id=>current_user.id).where(:motiontime.lte=>@endtime).where(:motiontime.gte=>@begintime).sum(item) 
				@data<<sum
 			end
    		@totaldata<<@data
			@data=[]           
    	end
	else
    	[:sedentary, :light, :moderate, :high, :vigorous].each do |item|
    		(1..count).each do |i|
    			sum=0
				@begintime=(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i,i-1,0,0)).to_s.split(' ')[0]+' '+(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i,i-1,0,0)).to_s.split(' ')[1]
				@endtime=(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i,i-1,59,59)).to_s.split(' ')[0]+' '+(Time.new(params[:begintime].split('-')[0].to_i,params[:begintime].split('-')[1].to_i,params[:begintime].split('-')[2].to_i,i-1,59,59)).to_s.split(' ')[1]
				sum+=Motiondata.where(:user_type=>'student', :user_id=>current_user.id).where(:motiontime.gte=>@begintime).where(:motiontime.lte=>@endtime).sum(item) 
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
