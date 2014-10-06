class RenameDisplaynameUsername < ActiveRecord::Migration
  def change
    rename_column :users, :displayname, :username
  end
end
