class CreateBasestations < ActiveRecord::Migration
  def change
    create_table :basestations do |t|
      t.string :name
      t.string :code
      t.boolean :status
      t.float :longitude
      t.string :ip
      t.float :latitude
      t.string :place

      t.timestamps
    end
  end
end
