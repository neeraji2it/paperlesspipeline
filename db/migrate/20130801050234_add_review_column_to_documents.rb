class AddReviewColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :review, :boolean
  end
end
