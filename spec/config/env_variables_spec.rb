# frozen_string_literal: true
# code: Environment variables such as SendGrid Keys and Passwords
# keys: config/local_env.yml : always ensure this is a .gitignore'd file
# test: spec/config/env_variables_spec.rb
# refs: Daniel Kehoe's article, Rails Environment Variables:
# http://railsapps.github.io/rails-environment-variables.html
require 'pry'
describe 'Environment variables' do
  describe 'SendGrid user_name' do
    # this tests env variables against config/secrets.yml which reads from your env variables $ env
    # to set this local env variable $ export SENDGRID_USERNAME=your_username
    # to set this heroku config variable in production:
    # $ heroku config:set SENDGRID_USERNAME=your_username
    # notice we can fetch/retrieve and test the keys in two ways
    it 'variable is set' do
      sendgrid_username = ENV.fetch('SENDGRID_USERNAME')
      expect(sendgrid_username).to match(/665/), 'Your SENDGRID_USERNAME is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid password' do
    # to set this env variable $ export SENDGRID_PASSWORD=your_sendgrid_password
    # to set this heroku config variable in production $ heroku config:add SENDGRID_PASSWORD=your_sendgrid_password
    it 'variable is set' do
      expect(ENV['SENDGRID_PASSWORD']).to match(/667/), 'Your SENDGRID_PASSWORD is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid api_key' do
    # to set this env variable $ export SENDGRID_API_KEY=your_sendgrid_api_key
    # to set this heroku config variable in production $ heroku config:add SENDGRID_PASSWORD=your_sendgrid_api_key
    it 'variable is set' do
      carnation = 'tarnation'
      tarn = carnation.split(//).shift(4).join.squeeze
      expect(ENV['SENDGRID_API_KEY']).to match(/tarn/), 'Your SENDGRID_API_KEY is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid smtp password' do
    # to set this env variable $ export SENDGRID_SMTP_PASSWORD=your_sendgrid_smtp_password
    # to set this heroku config variable in production $ heroku config:add SENDGRID_SMTP_PASSWORD=your_sendgrid_smtp_password
    it 'variable is set' do
      expect(ENV['SENDGRID_SMTP_PASSWORD']).to match(/pal/), 'Your SENDGRID_SMTP_PASSWORD is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid smtp username' do
    # to set this env variable $ export SENDGRID_SMTP_USERNAME=your_sendgrid_smtp_username
    # to set this heroku config variable in production $ heroku config:add SENDGRID_SMTP_USERNAME=your_sendgrid_smtp_username
    it 'variable is set' do
      expect(ENV['SENDGRID_SMTP_USERNAME']).to match(/visitmee/), 'Your SENDGRID_SMTP_USERNAME is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid smtp address' do
    # this tests env variables against config/secrets.yml which reads from your env variables $ env
    # to set this local env variable $ export SMTP_ADDRESS=your_smtp_address
    # to set this heroku config variable in production $ heroku config:add SMTP_ADDRESS=your_smtp_address
    # notice we can retrieve and test the keys in two ways
    it 'variable is set' do
      api_key = ENV.fetch('SMTP_ADDRESS')
      expect(api_key).to match(/mee/), 'Your SMTP_ADDRESS is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SMTP domain' do
    # to set this env variable $ export SMTP_DOMAIN=your_smtp_domain
    # to set this heroku config variable in production $ heroku config:add SMTP_DOMAIN=your_smtp_domain
    it 'variable is set' do
      expect(ENV['SMTP_DOMAIN']).to match(/visitmeet.herokuapp.com/), 'Your SMTP_DOMAIN is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'GITHUB_KEY' do
    it 'variable is set' do
      expect(ENV['GITHUB_KEY']).to match(/2121/), 'Your GITHUB_KEY is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'GITHUB_SECRET' do
    it 'variable is set' do
      expect(ENV['GITHUB_SECRET']).to match(/6655/), 'Your GITHUB_SECRET is not set, Please refer to Rails Environment Variables'
    end
  end
  describe 'GITHUB_OMNIAUTH_TEST_USERNAME' do
    it 'variable is set' do
      expect(ENV['GITHUB_OMNIAUTH_TEST_USERNAME']).to match(/visitmeet-test/), 'Your GITHUB_OMNIAUTH_TEST_USERNAME is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'GITHUB_OMNIAUTH_TEST_PASSWORD' do
    it 'variable is set' do
      expect(ENV['GITHUB_OMNIAUTH_TEST_PASSWORD']).to match(/al1/), 'Your GITHUB_OMNIAUTH_TEST_PASSWORD is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'AWS_ACCESS_KEY_ID' do
    it 'variable is set' do
      expect(ENV['AWS_ACCESS_KEY_ID']).to match(/N6J/), 'Your AWS_ACCESS_KEY_ID is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'AWS_SECRET_ACCESS_KEY' do
    it 'variable is set' do
      expect(ENV['AWS_SECRET_ACCESS_KEY']).to match(/6J7/), 'Your AWS_SECRET_ACCESS_KEY is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'MAILCHIMP_API_KEY' do
    it 'variable is set' do
      expect(ENV['MAILCHIMP_API_KEY']).to match(/678/), 'Your MAILCHIMP_API_KEY is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'MAILCHIMP_LIST_ID' do
    it 'variable is set' do
      expect(ENV['MAILCHIMP_LIST_ID']).to match(/669/), 'Your MAILCHIMP_LIST_ID is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'OMNIAUTH_APP_ID' do
    it 'variable is set' do
      expect(ENV['OMNIAUTH_APP_ID']).to match(/2121/), 'Your OMNIAUTH_APP_ID is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'OMNIAUTH_APP_SECRET' do
    it 'variable is set' do
      expect(ENV['OMNIAUTH_APP_SECRET']).to match(/6655/), 'Your OMNIAUTH_APP_SECRET is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'S3_BUCKET_NAME' do
    it 'variable is set' do
      expect(ENV['S3_BUCKET_NAME']).to match(/visitmeet/), 'Your S3_BUCKET_NAME is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SECRET_KEY' do
    it 'variable is set' do
      expect(ENV['SECRET_KEY']).to match(/667/), 'Your SECRET_KEY is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SECRET_KEY_BASE' do
    it 'variable is set' do
      expect(ENV['SECRET_KEY_BASE']).to match(/0099/), 'Your SECRET_KEY_BASE is not set, Please refer to Rails Environment Variables'
    end
  end

  # Bishisht - Paperclip tests?
  # describe 'PaperClip' do
  # it 'variables are set' do
  # # expect(config.paperclip_defaults).to be_an Array
  # # expect(config.paperclip_defaults.storage).to eq ':s3'
  # # expect(config.paperclip_defaults.storage[:s3_credentials].count).to eq 3
  # # expect(config.paperclip_defaults.storage[:s3_credentials][:bucket]).to eq "ENV['S3_BUCKET_NAME']"
  # # expect(config.paperclip_defaults.storage[:s3_credentials][:access_key_id]).to eq "ENV['AWS_ACCESS_KEY_ID']"
  # # expect(config.paperclip_defaults.storage[:s3_credentials][:secret_access_key]).to eq "ENV['AWS_SECRET_ACCESS_KEY']"
  # end
end
