class EmailProcessor < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.process(email)
    Document.create(:document_file_name => email.body)
  end

end
