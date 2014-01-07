class Manager < ActiveRecord::Base
  attr_accessible :email, :login_id, :name, :sex
  belongs_to :login
end
