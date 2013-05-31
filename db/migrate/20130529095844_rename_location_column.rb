class RenameLocationColumn < ActiveRecord::Migration
  def up
    rename_column :locations, :location, :name
  end

  def down
  end
end
