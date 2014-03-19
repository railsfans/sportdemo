class CreateGradeteachers < ActiveRecord::Migration
  def change
    create_table :gradeteachers do |t|
      t.string :name
      t.string :email
      t.boolean :sex
      t.integer :login_id
      t.string :phone

      t.timestamps
    end
  end
end
