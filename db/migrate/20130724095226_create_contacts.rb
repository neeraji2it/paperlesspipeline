class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :role
      t.string :phone
      t.string :fax
      t.string :email
      t.integer :transaction_id
      t.timestamps
    end
  end
end
