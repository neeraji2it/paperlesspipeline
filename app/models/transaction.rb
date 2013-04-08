class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  attr_accessible :user_id,:location_id, :transaction_name,:transaction_number,:status,:close_date,:more_info,:automatic_expire_date,:buyer_name,:seller_name,:list_price,:sale_price,:total_commission,:commission_summary,:listing,:selling,:outside_listing_agent_name,:outside_selling_agent_name
  validates :transaction_name,:transaction_number,:status,:close_date,:more_info,:buyer_name,:seller_name,:list_price,:sale_price,:total_commission,:commission_summary, :presence => true

  define_index do
    indexes transaction_name
  end
  
end
