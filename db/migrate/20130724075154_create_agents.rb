class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.integer :transaction_id
      t.integer :user_id
      t.boolean :listing
      t.boolean :selling
      t.timestamps
    end
  end
end
