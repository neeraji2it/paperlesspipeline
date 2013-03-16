class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :transaction_name
      t.string :transaction_number
      t.string :status
      t.date :close_date
      t.text :more_info
      t.date :automatic_expire_date
      t.string :buyer_name
      t.string :seller_name
      t.string :list_price
      t.string :sale_price
      t.string :total_commission
      t.string :commission_summary
      t.string :listing
      t.string :selling
      t.string :outside_listing_agent_name
      t.string :outside_selling_agent_name

      t.timestamps
    end
  end
end
