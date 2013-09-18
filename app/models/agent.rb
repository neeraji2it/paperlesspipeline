class Agent < ActiveRecord::Base
  attr_accessible :transaction_id, :user_id, :listing, :selling
end
