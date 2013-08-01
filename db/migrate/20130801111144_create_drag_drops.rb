class CreateDragDrops < ActiveRecord::Migration
  def change
    create_table :drag_drops do |t|
      t.string :document_file_name
      t.string :document_content_type
      t.integer :document_file_size

      t.timestamps
    end
  end
end
