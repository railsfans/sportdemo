class Softfeedback < ActiveRecord::Base
  attr_accessible :account, :content, :model, :os, :version
end
