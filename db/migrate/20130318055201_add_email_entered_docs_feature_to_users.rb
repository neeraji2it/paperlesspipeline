class AddEmailEnteredDocsFeatureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :entered_docs_feature, :boolean
  end
end
