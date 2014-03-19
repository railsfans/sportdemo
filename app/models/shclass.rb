class Shclass < ActiveRecord::Base
  attr_accessible :name, :shgrade_id
  has_many :teachers, :through=>:shclass_teachers
  has_many :shclass_teachers
  has_many :students
	belongs_to :shgrade
end
