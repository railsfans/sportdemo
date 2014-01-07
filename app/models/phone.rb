class Phone < ActiveRecord::Base
  attr_accessible :SDK, :deviceID, :login_id, :model, :usertype, :versioncode
end
