class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :name
      t.datetime :begintime
      t.datetime :endtime
      t.boolean :status
      t.integer :teacher_id

      t.timestamps
    end
  end
end
