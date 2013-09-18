class EmailProcessor < ActionMailer::Base
  def receive(message)
    for recipient in message.to
      User.find_by_email(recipient).update_attribute(:company_name, message.body)
    end
  end
end
