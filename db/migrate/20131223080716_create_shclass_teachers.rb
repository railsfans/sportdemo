class CreateShclassTeachers < ActiveRecord::Migration
  def change
    create_table :shclass_teachers do |t|
      t.integer :shclass_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
