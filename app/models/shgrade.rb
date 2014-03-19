class Shgrade < ActiveRecord::Base
  attr_accessible :name
	has_many :gradeteachers, :through=>:shgrade_gradeteachers
	has_many :shgrade_gradeteachers
	has_many :shclasses
end
