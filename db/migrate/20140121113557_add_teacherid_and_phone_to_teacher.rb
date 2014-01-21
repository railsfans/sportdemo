class AddTeacheridAndPhoneToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :teacherid, :string
    add_column :teachers, :phone, :string
  end
end
