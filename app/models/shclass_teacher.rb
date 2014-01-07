class ShclassTeacher < ActiveRecord::Base
  attr_accessible :shclass_id, :teacher_id
  belongs_to :shclass
  belongs_to :teacher
end
