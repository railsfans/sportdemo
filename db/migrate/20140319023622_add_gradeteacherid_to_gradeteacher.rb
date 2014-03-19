class AddGradeteacheridToGradeteacher < ActiveRecord::Migration
  def change
    add_column :gradeteachers, :gradeteacherid, :string
  end
end
