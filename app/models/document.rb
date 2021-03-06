class Document < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  belongs_to :transaction
  attr_accessible :user_id, :document,:location_id,:document_type, :document_file_name,
    :review, :transaction_id, :doc_type, :entered,:assigned
  has_attached_file :document, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  has_many :comments, :dependent => :destroy
  validates_attachment_presence :document
  before_post_process :resize_images
  
  # Helper method to determine whether or not an attachment is an image.
  def image?
    document_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  define_index do
    indexes document_file_name
  end

  private

  def resize_images
    return false unless image?
  end

  

end
