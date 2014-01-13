class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :login_id
      t.string :usertype
      t.integer :step
      t.float :calorie
      t.float :distance
      t.float :activetime

      t.timestamps
    end
  end
end
