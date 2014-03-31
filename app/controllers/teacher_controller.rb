class TeacherController < ApplicationController
layout "teacher" 
before_filter :authenticate_teacher
def index
end

def gettreenode
	@matcharr=[]
	if params[:name]=='root'
		@class=Teacher.where(:login_id=>current_user.id).first.shclasses
		@class.each do |i|
			@matcharr<<Shgrade.find(i.shgrade_id).name if !@matcharr.include? Shgrade.find(i.shgrade_id).name
		end
		@type='grade'
	else if params[:name].slice(params[:name].length-1,1)!=t(:classname)
		@class=Teacher.where(:login_id=>current_user.id).first.shclasses
		@class.each do |i|
			@matcharr<<i.name
		end		
		@type='class'
	else  
		@type='student'
	end
	end
	respond_to do |format|	
		format.json { render :json=>@matcharr.collect { |list| { :name=>list,  :type=>@type }} }
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

def testload
	 
end

def classgrid
	@class=Teacher.where(:login_id=>current_user.id).first.shclasses
	respond_to do |format|
		format.js
		format.html
		format.json { render :json=>{ :totalCount=>@class.count, :gridData=>@class.collect{ |list| { :id=>list.id, :classname=>list.name, :count=>list.students.count, :gradename=>Shgrade.find(list.shgrade_id).name, :time=>'pass week' }} }}
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
