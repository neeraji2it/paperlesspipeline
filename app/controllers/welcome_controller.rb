class WelcomeController < ApplicationController
  def index
  end
#
#  def authenticate
#    callback = quickbooks_oauth_callback_url
#    token = $qb_oauth_consumer.get_request_token(:oauth_callback => callback)
#    session[:qb_request_token] = token
#    redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
#  end
#  
#  def oauth_callback
#    at = session[:qb_request_token].get_access_token(:oauth_verifier => params[:oauth_verifier])
#    token = at.token
#    secret = at.secret
#    realm_id = params['realmId']
#    # store the token, secret & RealmID somewhere for this user, you will need all 3 to work with Quickeebooks
#  end

  def email_update
    message = Mail.new(params[:message])
    for recipient in message.to
      User.find_by_email(recipient).update_attribute(:company_name, message.body)
    end
  end

end
