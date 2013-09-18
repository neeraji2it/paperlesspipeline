class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  attr_accessible :comment, :user_id,:document_id
  validates :comment, :presence => true
end
