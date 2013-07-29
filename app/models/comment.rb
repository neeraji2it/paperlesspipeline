class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :document
  attr_accessible :comment, :user_id,:document_id
  validate :comment , :presence => true
end
