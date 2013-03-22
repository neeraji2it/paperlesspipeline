class AddCreatedByToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :created_by, :integer
  end
end
