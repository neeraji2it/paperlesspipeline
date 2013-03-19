class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmable,:current_password,:name,
  :duplicate_document_uploads, :email_transaction_reminders, :allow_pdf, :entered_docs_feature,:location
  # attr_accessible :title, :body
  validates :password, :presence =>true,
    :length => { :minimum => 6, :maximum => 15,:message => 'should be  a minimum of 6 characters and a maximum of 15 characters.' },
    :confirmation =>true,:on => :create
  validates :password, :presence =>true,
    :length => { :minimum => 6, :maximum => 15,:message => 'should be  a minimum of 6 characters and a maximum of 15 characters.' },
    :confirmation =>true, :unless => lambda {|u| u.password.nil? },:on => :update
  has_many :transactions, :dependent => :destroy
end
