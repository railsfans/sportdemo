class Basestation < ActiveRecord::Base
  attr_accessible :code, :ip, :latitude, :longitude, :name, :place, :status
end
