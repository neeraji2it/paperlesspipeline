class Contact < ActiveRecord::Base
  attr_accessible :name, :role, :phone, :fax, :email, :transaction_id
  validates :name, :role, :presence => true
  belongs_to :transaction
end
