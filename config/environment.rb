# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Iamin::Application.initialize!

# Set up mail delivery
# With heroku's sendgrid addon, SMTP doesn't need to be configured
config.action_mailer.raise_delivery_errors = true