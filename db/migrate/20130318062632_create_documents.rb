class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id
      t.string :document_file_name
      t.string :document_content_type
      t.integer :document_file_size

      t.timestamps
    end
  end
end
