class AddResetPasswdFieldToStudent < ActiveRecord::Migration
  def change
    add_column :students, :passwdtoken, :string
    add_column :students, :passwdstatus, :boolean
    add_column :students, :resetpwdtime, :string
    add_column :students, :last_logintime, :string
  end
end
