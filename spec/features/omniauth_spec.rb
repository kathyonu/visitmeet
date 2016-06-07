# frozen_string_literal: true
# code: app/controllers/users/omniauth_callbacks_controller.rb
# code: spec/support/integration_spec_helper.rb
# code: spec/rails_helper.rb 
# test: spec/features/integration_spec.rb
# test: spec/features/omniauth_spec.rb
# require 'pry'
feature 'testing oauth' do
  scenario 'allows github user to sign in' do
    visit '/'
    expect(page).to have_content 'Sign in with Github'

    click_on 'Sign in with Github'
    expect(current_path).to eq '/'
    # binding.pry
    # login_with_oauth in spec/support/integration_spec_helper.rb
    # login_with_oauth
    login_with_oauth
    visit '/users/profile'

    # fill_in :login_field, with: ENV['GITHUB_TEST_USER_EMAIL']
    # fill_in :password, with: ENV['GITHUB_TEST_USER_PASSWORD']
    # click_on 'Sign in'

    # fill_in 'tiger_name', :with => 'Charlie'
    # fill_in 'tiger_blood', :with => 'yes'

    # click_on 'Create Tiger'

    # page.should have_content("Thanks! You are a winner!")
  end
end