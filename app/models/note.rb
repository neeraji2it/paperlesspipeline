class Note < ActiveRecord::Base
  attr_accessible :transaction_id, :description, :checklist_id
  belongs_to :transaction
  belongs_to :user
end
