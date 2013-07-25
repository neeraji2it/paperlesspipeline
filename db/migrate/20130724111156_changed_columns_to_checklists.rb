class ChangedColumnsToChecklists < ActiveRecord::Migration
 def change
    add_column :checklists, :transaction_id, :integer
  end
end
