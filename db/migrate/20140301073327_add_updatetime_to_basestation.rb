class AddUpdatetimeToBasestation < ActiveRecord::Migration
  def change
    add_column :basestations, :updatetime, :integer
  end
end
