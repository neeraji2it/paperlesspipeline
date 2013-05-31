class AddExpirationDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :expiration_date, :date
  end
end
