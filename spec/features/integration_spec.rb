# frozen_string_literal: true
# code: app/controllers/users/omniauth_callbacks_controller.rb
# code: spec/support/integration_spec_helper.rb
# code: spec/rails_helper.rb 
# test: spec/features/integration_spec.rb
# test: spec/features/omniauth_spec.rb

# notes:
# ref : "http://stackoverflow.com/questions/13805604/trying-to-test-omniauth-with-rspec-capybara-failing"

# DONE: 20160530
# Create spec/support/integration_spec_helper.rb with:
# module IntegrationSpecHelper
# #  def login_with_oauth(service = :github)
# #    visit "/auth/#{service}"
# #  end
# end

# DONE
# OmniAuth.config.add_mock(
#    :github, 
#    {
#        info: {
#        username: ENV['GITHUB_TEST_USER_USERNAME']
#        password: ENV['GITHUB_TEST_USER_PASSWORD']
#    }
#})

# inside the rails_helper.rb Rspec.configure do block.
# DONE
# config.include(IntegrationSpecHelper, :type => :feature)
#
# Create spec/features/omniauth_spec.rb
# require 'spec_helper' : no longer required
# DONE
# feature 'testing oauth' do
#  scenario 'should create a new tiger' do
#    login_with_oauth
#    visit new_tiger_path # first failure expected
#
#    fill_in 'tiger_name', :with => 'Charlie'
#    fill_in 'tiger_blood', :with => 'yes'
#
#    click_on 'Create Tiger'
#
#    page.should have_content("Thanks! You are a winner!")
#  end
# end

