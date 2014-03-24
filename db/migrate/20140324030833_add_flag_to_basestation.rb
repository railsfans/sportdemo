class AddFlagToBasestation < ActiveRecord::Migration
  def change
    add_column :basestations, :reqlogflag, :string, :default=>'1'
    add_column :basestations, :setparamsflag, :string, :default=>'1'
    add_column :basestations, :logcontent, :string
  end
end
