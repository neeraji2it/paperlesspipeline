class AddedDocTypeToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :doc_type, :string
    add_column :documents, :reviewed, :boolean, :default => false
    add_column :documents, :transaction_id, :integer
  end
end
