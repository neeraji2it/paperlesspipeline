class AddEmailTransactionRemindersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_transaction_reminders, :boolean
  end
end
