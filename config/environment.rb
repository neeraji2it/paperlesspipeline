# Load the rails application
require File.expand_path('../application', __FILE__)

if ENV['RAILS_ENV'] == "staging"
  ActiveSupport::Deprecation.silenced = true
end

ActiveSupport::Deprecation.silenced = true 
# Initialize the rails application
Paperlesspipeline::Application.initialize!