class Location < ActiveRecord::Base
  attr_accessible :location, :user_id
  belongs_to :user
  has_many :documents, :dependent => :destroy
end
