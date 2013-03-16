class AddAllowPdfToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allow_pdf, :string
  end
end
