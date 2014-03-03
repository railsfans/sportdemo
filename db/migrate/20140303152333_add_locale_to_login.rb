class AddLocaleToLogin < ActiveRecord::Migration
  def change
    add_column :logins, :locale, :string
  end
end
