class AddLocationIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :location_id, :integer
  end
end
