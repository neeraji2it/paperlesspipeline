class Location < ActiveRecord::Base
  attr_accessible :location, :user_id
  belongs_to :users
end
