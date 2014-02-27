class ChangeLongitudeAndLatitudeFormtInBasestation < ActiveRecord::Migration
  def up
	change_column :basestations, :longitude, :decimal, :precision => 10, :scale => 2
	change_column :basestations, :latitude, :decimal, :precision=>10, :scale=>2
  end

  def down
	change_column :basestations, :longitude, :float
	change_column :basestations, :latitude, :float
  end
end
