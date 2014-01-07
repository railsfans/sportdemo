class Phonelock < ActiveRecord::Base
  attr_accessible :login_id, :status, :token
end
