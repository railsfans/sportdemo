class CreateShclasses < ActiveRecord::Migration
  def change
    create_table :shclasses do |t|
      t.string :name
      t.integer :shgrade_id

      t.timestamps
    end
  end
end
