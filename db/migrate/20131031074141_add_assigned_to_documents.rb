class AddAssignedToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :assigned, :boolean
  end
end
