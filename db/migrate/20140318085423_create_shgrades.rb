class CreateShgrades < ActiveRecord::Migration
  def change
    create_table :shgrades do |t|
      t.string :name

      t.timestamps
    end
  end
end
