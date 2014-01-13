class Target < ActiveRecord::Base
  attr_accessible :activetime, :calorie, :distance, :login_id, :step, :usertype
	belongs_to :login
end
