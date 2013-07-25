class Checklist < ActiveRecord::Base
  attr_accessible :transaction_id, :name
  
  belongs_to :transaction
  has_many :tasks
  
  define_index do
    indexes name
  end
  
end
