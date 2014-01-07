class Teacher < ActiveRecord::Base
  attr_accessible :email, :login_id, :name, :sex
  has_one :login
  has_many :shclasses, :through=>:shclass_teachers
  has_many :shclass_teachers
end
