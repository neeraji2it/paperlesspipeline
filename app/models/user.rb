class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  devise :authenticatable, :timeoutable, :validatable, :timeout_in => 15.minutes

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmable,:current_password,:name,
  :duplicate_document_uploads, :email_transaction_reminders, :allow_pdf, :entered_docs_feature,:location,:photo,:avatar,:active,:confirmation_token,:confirmed_at,
  :first_name, :last_name, :company_name, :phone_number
  # attr_accessible :title, :body
  
  #validations======================================================================================================================================
  validates :password, :presence =>true,
    :length => { :minimum => 6, :maximum => 15,:message => 'should be  a minimum of 6 characters and a maximum of 15 characters.' },
    :confirmation =>true,:on => :create
  validates :password, :presence =>true,
    :length => { :minimum => 6, :maximum => 15,:message => 'should be  a minimum of 6 characters and a maximum of 15 characters.' },
    :confirmation =>true, :unless => lambda {|u| u.password.nil? },:on => :update
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
end
