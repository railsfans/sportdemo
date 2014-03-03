require 'digest'
class Login < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :hashed_password, :username, :usertype, :password_confirmation, :password, :locale
	validates :password, :confirmation => true, :presence => true, :if => :password_required?
	before_save :encrypt_new_password 
	validates :username, :uniqueness => true 
    
    has_one :teacher
    has_one :manager
    has_one :student
	has_one :target

	has_many :devices
   
	def self.authenticate(username, password, usertype) 
		user = find_by_username_and_usertype(username, usertype) 
		return user if user && user.authenticated?(password) 
	end 

   	def self.phone_authenticate(username, password) 
		user = Login.where(:username=>username, :hashed_password=>password)
		return user  
	end 

	def authenticated?(password) 
		self.hashed_password == encrypt(password) 
	end 

	protected 

	def encrypt_new_password 
		return if password.blank? 
		self.hashed_password = encrypt(password) 
	end 

	def password_required? 
		hashed_password.blank? || password.present? 
	end

	def encrypt(string) 
		Digest::SHA1.hexdigest(string) 
	end 

	def self.authenticate_user(user_id, password) 
		user = find_by_id(user_id) 
		return user if user && user.authenticated?(password) 
	end 
	
	def self.newpass(len)
		chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
		newpass = ""
		1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
		return newpass
	end 

	def self.getuserinfo(id)
		case Login.find(id).usertype
		when 'student'
  			return Student.where(:login_id=>id)
		when 'teacher'
  			return Teacher.where(:login_id=>id)
		when 'manager'
  			return Manager.where(:login_id=>id)
		else
  			puts "others"
		end
	end
				
end
