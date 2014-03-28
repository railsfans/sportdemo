namespace :export do
  desc "Prints Motiondata.all in a seeds.rb way."
  task :seeds_format => :environment do
    Motiondata.all.each do |data|
      puts "Motiondata.create(#{data.serializable_hash.delete_if {|key, value| ['step','distance','calorie'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end
