# frozen_string_literal: true
# code: config/environment.rb
# test: to be determined
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# $ host visitmeet.herokuapp.com
# visitmeet.herokuapp.com is an alias for us-east-1-a.route.herokuapp.com
# us-east-1-a.route.herokuapp.com has address 54.243.177.204
ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: '587',
  authentication: :plain,
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  # If you’re .. you are using the Cedar stack,
  # you will need to setup your email framework manually
  # https://devcenter.heroku.com/articles/sendgrid
  domain: 'visitmeet.herokuapp.com',
  # domain: 'visitmeet.herokuapp.com',
  enable_starttls_auto: true
}
