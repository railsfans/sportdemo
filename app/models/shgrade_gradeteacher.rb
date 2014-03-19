class ShgradeGradeteacher < ActiveRecord::Base
  attr_accessible :gradeteacher_id, :shgrade_id
	belongs_to :shgrade
	belongs_to :gradeteacher
end
