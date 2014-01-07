class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.integer :shclass_id
      t.integer :point
      t.string :email
      t.boolean :sex
      t.float :height
      t.float :weight
      t.integer :login_id

      t.timestamps
    end
  end
end
