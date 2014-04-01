class TeacherController < ApplicationController
layout "teacher" 
before_filter :authenticate_teacher
def index
end

def gettreenode
	@matcharr=[]
	p params[:name]
	p params[:name].slice(params[:name].length-1,1)!=t(:classname)
	if params[:name]=='root'
		@class=Teacher.where(:login_id=>current_user.id).first.shclasses
		@class.each do |i|
			@matcharr<<Shgrade.find(i.shgrade_id).name if !@matcharr.include? Shgrade.find(i.shgrade_id).name
		end
		@type='grade'
	else  
		@class=Teacher.where(:login_id=>current_user.id).first.shclasses
		@class.each do |i|
			@matcharr<<i.name
		end		
		@type='class'
	end
	respond_to do |format|	
		format.json { render :json=>@matcharr.collect { |list| { :type=>@type, :name=>list, :id=>list }} }
	end
end

def personinfo
	@user=Teacher.first
end

def loadform
	@user=Teacher.first
	render :layout=>false
end

def classcalgraph
	render :layout=>false
end

def loaddata 
	@data=[]
    @totaldata=[]
    @items=[t(:sedentary), t(:light), t(:moderate), t(:high), t(:vigorous)]
	p params[:time]==t('pass alldata')
	if params[:time]=t('pass week')
	    [:sedentary, :light, :moderate, :high, :vigorous].each do |item|
	    	(0..6).each do |i|
	    		sum=0
				@time_begin=(Time.now.beginning_of_day-7.days+i.days).to_s.split(' ')[0]+' '+(Time.now.beginning_of_day-7.days+i.days).to_s.split(' ')[1]
				@time_end=(Time.now.end_of_day-7.days+i.days).to_s.split(' ')[0]+' '+(Time.now.end_of_day-7.days+i.days).to_s.split(' ')[1]
				Shclass.find(params[:id]).students.each do |stu|
					sum+=Motiondata.where(:user_type=>'student', :user_id=>stu.id).where(:motiontime.lte=>@time_end).where(:motiontime.gte=>@time_begin).sum(item)
				end 
				@data<<sum
	 		end
	    	@totaldata<<@data
			@data=[]           
	    end
	else if params[:time]==t('pass month')
		[:sedentary, :light, :moderate, :high, :vigorous].each do |item|
	    	(0..9).each do |i|
	    		sum=0
				@time_begin=(Time.now.beginning_of_day-30.days+(i*3).days).to_s.split(' ')[0]+' '+(Time.now.beginning_of_day-30.days+(i*3).days).to_s.split(' ')[1]
				@time_end=(Time.now.end_of_day-30.days+((i+1)*3).days).to_s.split(' ')[0]+' '+(Time.now.end_of_day-30.days+((i+1)*3).days).to_s.split(' ')[1]
				Shclass.find(params[:id]).students.each do |stu|
					sum+=Motiondata.where(:user_type=>'student', :user_id=>stu.id).where(:motiontime.lte=>@time_end).where(:motiontime.gte=>@time_begin).sum(item)
				end 
				@data<<sum
	 		end
	    	@totaldata<<@data
			@data=[]           
	    end
		p @totaldata
	else if params[:time]==t('pass alldata')
		@total=0
		[:sedentary, :light, :moderate, :high, :vigorous].each do |item|
			sum=0
			Shclass.find(params[:id]).students.each do |stu|
				sum+=Motiondata.where(:user_type=>'student', :user_id=>stu.id).sum(item)
			end 
			@data<<sum
			@total+=sum
		end
		p @data
		@data.each do |t|
#			@totaldata<<(t/total.to_f).round(2)
		end
	end
	end
	end
	respond_to do |format|
        format.json { render :json=>{ :data=>@totaldata, :items=>@items} }
	end
end

def testload
	 
end

def classgrid
	@class=Teacher.where(:login_id=>current_user.id).first.shclasses
	respond_to do |format|
		format.js
		format.html
		format.json { render :json=>{ :totalCount=>@class.count, :gridData=>@class.collect{ |list| { :id=>list.id, :classname=>list.name, :count=>list.students.count, :gradename=>Shgrade.find(list.shgrade_id).name, :time=>t('pass week') }} }}
	end
end
def studentgrid
	@student=Shclass.find(params[:shclass_id]).students
	respond_to do |format|
		format.js
		format.json { render :json=>{ :totalCount=>@student.count, :gridData=>@student.collect{ |list| { :id=>list.id, :realname=>list.name,:height=>list.height,:weight=>list.weight,:sex=>list.sex==true ? 'male' : 'female' }} }}
	end
end
def motiongrid
	@motiondata=Motiondata.where(:user_id=>params[:user_id])
	respond_to do |format|
		format.js
		format.json { render :json=>{ :totalCount=>@motiondata.count, :gridData=>@motiondata }}
	end
end
def semestergrid
	p current_user.id
	@semester=Semester.where(:teacher_id=>Teacher.where(:login_id=>current_user).first.id)
	respond_to do |format|
		format.js
		format.html
		format.json { render :json=>{ :totalCount=>@semester.count, :gridData=>@semester.collect{ |list| { :id=>list.id, :begintime=>list.begintime.strftime("%Y-%m-%d"),:endtime=>list.endtime.strftime("%Y-%m-%d"),:status=>list.status==true ? 'active' : 'unactive' ,:name=>list.name }} }}
	end
end
def updatesemesterdata
	p params[:begintime].split('T')[0].split('-')[0]
	p params[:begintime]
	params[:begintime].split('T')[0].split('-')[1]
	p Time.new(params[:begintime].split('T')[0].split('-')[0],params[:begintime].split('T')[0].split('-')[1],params[:begintime].split('T')[0].split('-')[2])
	Semester.find(params[:id]).update_attributes(:name=>params[:name], :begintime=>Time.new(params[:begintime].split('T')[0].split('-')[0],params[:begintime].split('T')[0].split('-')[1],params[:begintime].split('T')[0].split('-')[2])+8.hours, :status=>params[:status]=='active' ? true : false, :endtime=>Time.new(params[:endtime].split('T')[0].split('-')[0],params[:endtime].split('T')[0].split('-')[1],params[:endtime].split('T')[0].split('-')[2])+8.hours)
	respond_to do |format|
		format.json { render :json=>{:success=>true}}
	end
end
end
