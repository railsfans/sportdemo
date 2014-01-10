class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :login_id
      t.integer :battery
      t.string :deviceid
      t.datetime :lastupdate

      t.timestamps
    end
  end
end
