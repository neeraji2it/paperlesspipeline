class AddEmailDupicateDocumentUploadsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :duplicate_document_uploads, :boolean
  end
end
