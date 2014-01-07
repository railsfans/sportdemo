class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :hashed_password
      t.string :username
      t.string :usertype

      t.timestamps
    end
  end
end
