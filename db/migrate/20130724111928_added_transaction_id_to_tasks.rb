class AddedTransactionIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :transaction_id, :integer
    add_column :tasks, :status, :boolean, :default => false
  end
end
