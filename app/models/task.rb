class Task < ActiveRecord::Base
  attr_accessible :transaction_id, :name, :checklist_id
  
  #associations ========================================================================================
  belongs_to :checklists
   belongs_to :transaction
  #=====================================================================================================
  validates :name, :presence => true
end
