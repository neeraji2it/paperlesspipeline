class Task < ActiveRecord::Base
  attr_accessible :checklist_id, :name
  
  #associations ========================================================================================
  belongs_to :checklists
  #=====================================================================================================
    
end
