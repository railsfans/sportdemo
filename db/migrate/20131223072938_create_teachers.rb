class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.integer :login_id
      t.boolean :sex

      t.timestamps
    end
  end
end
