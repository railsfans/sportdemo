class CreateShgradeGradeteachers < ActiveRecord::Migration
  def change
    create_table :shgrade_gradeteachers, :id=>false do |t|
      t.integer :shgrade_id
      t.integer :gradeteacher_id
    end
  end
end
