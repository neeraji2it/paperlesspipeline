class EmailProcessor < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.process(email)
    d = Document.create(:document_file_name => email.body)
    d.save
    puts "==========================================================================="
    puts d.inspect
    puts "==========================================================================="
  end

end
