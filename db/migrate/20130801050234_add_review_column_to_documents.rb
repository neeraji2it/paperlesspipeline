class AddReviewColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :review, :boolean
    add_column :documents, :entered, :boolean
  end
end
