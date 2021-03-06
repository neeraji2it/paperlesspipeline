class DragDrop < ActiveRecord::Base
  attr_accessible :document
  has_attached_file :document, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  before_post_process :resize_images
  validates_attachment_presence :document
  # Helper method to determine whether or not an attachment is an image.
  def image?
    document_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  def resize_images
    return false unless image?
  end
end
