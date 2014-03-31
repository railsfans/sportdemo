class AddHeadpicToStudent < ActiveRecord::Migration
  def change
    add_column :students, :headpic, :string
  end
end
