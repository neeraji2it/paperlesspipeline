require 'oauth'

if Rails.env == "development"
  QB_KEY = "qyprdfkHiHG3fYGXMsyWbVtPGnqBbv"
  QB_SECRET = "2UG9XLZQLbBkR6ise8QuDLT8IuHpaiguFegAx39E"
else
  QB_KEY = "qyprdQG4yt2AwQhFisKQQUYzh9kEeJ"
  QB_SECRET = "V7XlmQXVflO0hhd4yK385OVkHr3zT7DT6qn0ouPo"
end

$qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
    :site                 => "https://oauth.intuit.com",
    :request_token_path   => "/oauth/v1/get_request_token",
    :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
    :access_token_path    => "/oauth/v1/get_access_token"
  })