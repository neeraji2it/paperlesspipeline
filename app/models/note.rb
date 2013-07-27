class Note < ActiveRecord::Base
  attr_accessible :transaction_id, :note, :checklist_id
  belongs_to :transaction
end
