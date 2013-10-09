class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :checklists, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  attr_accessible :user_id,:location_id, :transaction_name,:transaction_number,:status,:close_date,:more_info,:automatic_expire_date,:buyer_name,:seller_name,:list_price,:sale_price,:total_commission,:commission_summary,:listing,:selling,:outside_listing_agent_name,:outside_selling_agent_name
  validates :transaction_name,:transaction_number,:status,:more_info,:buyer_name,:seller_name,:total_commission,:commission_summary, :presence => true
  validates :list_price, :presence => true
  validates :sale_price, :presence => true

  before_save :generate_email

  define_index do
    indexes transaction_name
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  private
  def generate_email
    @user = User.find(self.user_id)
    self.email = @user.email+'@ec2-54-245-14-77.us-west-2.compute.amazonaws.com'
  end
  
end
