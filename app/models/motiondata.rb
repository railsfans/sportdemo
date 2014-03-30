class Motiondata
  include Mongoid::Document
  field :step, type: Integer
  field :calorie, type: Float
  field :distance, type: Float
  field :user_type, type: String
  field :user_id, type: Integer
#  field :motiontime, type: DateTime
  field :motiontime, type: String
  field :sedentary, type: Integer
  field :light, type: Integer
  field :moderate, type: Integer
  field :high, type: Integer
  field :vigorous, type: Integer
validates_presence_of  :user_type, :user_id
#validates_presence_of :step, :calorie, :distance, :user_type, :user_id, :motiontime
end
