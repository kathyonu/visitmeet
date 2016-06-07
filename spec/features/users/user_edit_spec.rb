# frozen_string_literal: true
# code: to be detemined what is being tested
# test: spec/features/users/user_edit_spec.rb
#
# see NOTE ON : include Devise::TestHelpers at top of
# # spec/features/users/sign_in_spec.rb
# # include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!
# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'User edit', :devise do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'user changes email address' do
    @user = FactoryGirl.create(:user)
    login_as @user
    # login_as(user, scope: :user)
    visit edit_user_registration_path(@user)
    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Current password', with: @user.password
    click_button 'Update'
    # expect(page).to have_content 'Welcome, newemail@example.com'
    # TODO: get this next tests working again:
    # expect(page).to have_content 'Your account has been updated successfully.'
    # TODO: this message now showing, can be edit to succinctness, i am racing through fixing tests
    expect(page).to have_content 'You updated your account successfully, but we need to verify your new email address. Please check your email and follow the confirm link to confirm your new email address.'
    txts = [I18n.t('devise.registrations.updated')]
    # we are testing with a FactoryGirl created user, that is confirmed upon creation.
    # expect(page).to have_content 'You updated your account successfully, but we need to verify your new email address. Please check your email and follow the confirm link to confirm your new email address'
    # txts = [I18n.t('devise.registrations.updated'), I18n.t('devise.registrations.update_needs_confirmation')]
    # expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  scenario 'user cannot cannot edit any other user profile', :user do
    @user = FactoryGirl.create(:user)
    @other = FactoryGirl.create(:user, email: 'other@example.com')
    login_as @user
    visit edit_user_registration_path(@other)
    expect(page).to have_content 'Edit user'
    expect(page).to have_field('Email', with: @user.email)
  end
end
