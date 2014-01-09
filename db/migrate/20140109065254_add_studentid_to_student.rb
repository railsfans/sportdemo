class AddStudentidToStudent < ActiveRecord::Migration
  def change
    add_column :students, :studentid, :string
  end
end
