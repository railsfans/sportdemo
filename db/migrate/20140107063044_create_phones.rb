class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :SDK
      t.string :deviceID
      t.string :versioncode
      t.string :model
      t.string :usertype
      t.integer :login_id

      t.timestamps
    end
  end
end
