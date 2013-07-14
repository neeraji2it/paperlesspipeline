class AddCreaterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :create_id, :integer
  end
end
