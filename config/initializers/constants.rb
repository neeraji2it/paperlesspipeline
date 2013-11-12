if Rails.env == 'development'
  BASE_URL = "http://localhost:3000/"
else
  BASE_URL = "http://ec2-54-245-14-77.us-west-2.compute.amazonaws.com/"
end