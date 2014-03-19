class Gradeteacher < ActiveRecord::Base
  attr_accessible :email, :login_id, :name, :phone, :sex, :gradeteacherid
	has_many :shgrades, :through=>:shgrade_gradeteachers
	has_many :shgrade_gradeteachers

	belongs_to :login
end
