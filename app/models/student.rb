class Student < ActiveRecord::Base
  attr_accessible :email, :height, :login_id, :name, :point, :sex, :shclass_id, :weight, :phone, :studentid, :passwdtoken, :passwdstatus, :resetpwdtime, :last_logintime
  has_one :login
  has_one :shclass
end
