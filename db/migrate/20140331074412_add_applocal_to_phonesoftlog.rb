class AddApplocalToPhonesoftlog < ActiveRecord::Migration
  def change
    add_column :phonesoftlogs, :applocal, :string
  end
end
