class Semester < ActiveRecord::Base
  attr_accessible :begintime, :endtime, :name, :status, :teacher_id
end
