class CreatePhonelocks < ActiveRecord::Migration
  def change
    create_table :phonelocks do |t|
      t.string :token
      t.boolean :status
      t.integer :login_id

      t.timestamps
    end
  end
end
