class Location < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :users
  has_many :documents, :dependent => :destroy
  has_many :transactions
  has_many :users
end
