class Basestation < ActiveRecord::Base
  attr_accessible :updatetime, :code, :ip, :latitude, :longitude, :name, :place, :status, :logcontent, :setparamsflag, :reqlogflag
end
