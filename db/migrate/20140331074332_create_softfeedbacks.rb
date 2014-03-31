class CreateSoftfeedbacks < ActiveRecord::Migration
  def change
    create_table :softfeedbacks do |t|
      t.string :os
      t.string :content
      t.string :version
      t.string :model
      t.string :account

      t.timestamps
    end
  end
end
