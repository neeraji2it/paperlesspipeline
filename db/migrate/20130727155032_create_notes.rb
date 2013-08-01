class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :description
      t.integer :transaction_id
      t.integer :user_id
      t.timestamps
    end
  end
end
