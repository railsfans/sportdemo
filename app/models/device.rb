class Device < ActiveRecord::Base
  attr_accessible :battery, :deviceid, :lastupdate, :login_id
end
