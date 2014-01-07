class Student < ActiveRecord::Base
  attr_accessible :email, :height, :login_id, :name, :point, :sex, :shclass_id, :weight
  has_one :login
  has_one :shclass
end
