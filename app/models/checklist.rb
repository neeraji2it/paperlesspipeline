class Checklist < ActiveRecord::Base
  attr_accessible :location_id, :name,:tasks_attributes, :created_by
  
  #validations===============================================================================
  belongs_to :lications
  has_many :tasks
  #==========================================================================================
  
  accepts_nested_attributes_for  :tasks,  :allow_destroy  => true,:reject_if => :all_blank
  
  define_index do
    indexes name
  end
  
end
