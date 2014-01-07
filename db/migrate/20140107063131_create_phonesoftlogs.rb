class CreatePhonesoftlogs < ActiveRecord::Migration
  def change
    create_table :phonesoftlogs do |t|
      t.string :versioncode
      t.datetime :updatetime
      t.text :softinfo

      t.timestamps
    end
  end
end
