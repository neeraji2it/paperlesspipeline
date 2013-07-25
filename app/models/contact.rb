class Contact < ActiveRecord::Base
  attr_accessible :name, :role, :phone, :fax, :email, :transaction_id
end
