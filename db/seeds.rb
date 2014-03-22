# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#if ARGV.count==0
#	p "please enter the number to create data"
#	exit 0
#else if ARGV.count>1
#	p "you enter too many params"
#	exit 0
#end
#end
p "begin create data"
(1..14).each do |i|
	Motiondata.create(:step=>(100*rand()).to_i, :distance=>(200*rand()).round(2), :calorie=>(200*rand()).round(2), :motiontime=>Time.now-7.days+i.days+8.hours, :user_type=>'student', :user_id=>1)

end
