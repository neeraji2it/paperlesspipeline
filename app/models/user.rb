class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmable,:current_password,:name,
    :duplicate_document_uploads, :email_transaction_reminders, :allow_pdf, :entered_docs_feature,:location,:photo,:avatar,:active,:confirmation_token,:confirmed_at,
    :first_name, :last_name, :company_name, :phone_number,:role,:create_id
  # attr_accessible :title, :body
  
  #validations======================================================================================================================================
  validates :email,
    :uniqueness => true,  :length => { :maximum => 90, :minimum => 6 },
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
    :length => { :minimum => 6, :maximum => 15,:message => 'should be  a minimum of 6 characters and a maximum of 15 characters.' },
    :confirmation =>true,:on => :create
  validates :phone_number, :presence => true
  validates :first_name, :presence => {:message => "is required"}
  validates :last_name, :presence => {:message => "is required"}
  validates :company_name, :presence => {:message => "is required"}
  validates :password_confirmation, :presence => {:message => "is required"}
  #=================================================================================================================================================
  
  #Associations=====================================================================================================================================
  has_many :transactions, :dependent => :destroy
  has_many :docuemts, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_attached_file :avatar, :styles => { :thumb=> "100x100#", :small  => "400x400>" } if (Rails.env == 'development')
  
  has_attached_file :avatar,
    :whiny => false,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "uploaded_files/profile/:id/:style/:basename.:extension",
    :bucket => "PaperlessPipeline",
    :styles => {
    :original => "900x900>",
    :default => "280x190>",
    :other => "96x96>" } if (Rails.env == 'staging')
  #=================================================================================================================================================

  define_index do
    indexes role
  end
   
  def confirmation_required?
    !confirmed?
  end

  def total_commissioned
    total_commission1 = 0
    self.transactions.each do |i|
      total_commission1 += i.total_commission.to_i
    end
    return total_commission1
  end

  def full_name
    self.first_name+' '+self.last_name
  end

end
