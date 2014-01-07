class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :name
      t.string :email
      t.integer :login_id
      t.boolean :sex

      t.timestamps
    end
  end
end
