class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :checklist_id
      t.string :name

      t.timestamps
    end
  end
end
