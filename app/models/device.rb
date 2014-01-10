class Device < ActiveRecord::Base
  attr_accessible :battery, :deviceid, :lastupdate, :login_id
	belongs_to :login
end
