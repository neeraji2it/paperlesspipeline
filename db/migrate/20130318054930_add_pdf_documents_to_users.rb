class AddPdfDocumentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pdf_documents, :boolean
  end
end
