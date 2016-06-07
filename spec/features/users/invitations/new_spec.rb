# frozen_string_literal: true
# code: app/views/users/invitations/new.html.erb
# test: spec/features/users/invitations/new_spec.rb
# test: spec/features/users/invitations/edit_spec.rb
# flow: an invitation is created with new_user_invitation_path information being
# # passed to the user_invitation_path create method. are invitations recorded
# # against both users ?  is the same ITs recorded in current user and the
# # non-user receiving the IT ? It should be, it must be, so we needs must test it.
# # TODO: 20160607 : write test confirming relationship between current user and
# # the new user created with the ITs' email address, awaiting acceptance, then
# # the new user is confirmed as a valid user.
#
# #       Prefix           Verb           URI Pattern                 Controller#Action
# # accept_user_invitation GET    /users/invitation/accept(.:format)  devise/invitations#edit
# # remove_user_invitation GET    /users/invitation/remove(.:format)  devise/invitations#destroy
# #        user_invitation POST   /users/invitation(.:format)         devise/invitations#create
# #    new_user_invitation GET    /users/invitation/new(.:format)     devise/invitations#new
# #                        PATCH  /users/invitation(.:format)         devise/invitations#update
# #                        PUT    /users/invitation(.:format)         devise/invitations#update
#
require 'pry'
# include Selectors # module not used yet : /spec/support/selectors.rb
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

# Feature: User invitations
#   As a user
#   I want to invite someone to use the site
#   So I send my Invitation Token to them
feature 'New Invitations', :devise, js: true do
  after(:each) do
    Warden.test_reset!
  end

  # As a signed in user with an Issued INVITATION_TOKEN
  # I want to send my IT to a friend, using their email
  # I arrive at the new invitations page
  # I fill in their email, and my message and token
  # When I press send, the IT-link is sent, and its issue is recorded in my account
  # The IT is also recorded with the email that it has been sent to
  # This necessitates a NEW USER being created, with that email ?
  # Yes, is my guess, and that new user sits silent until IT acceptance, or expiry
  scenario 'User can send Invitation Token to someone' do
    pending 'still needs more work'
    # first, lets make sure a non-user cannot get in
    visit new_user_invitation_path
    expect(current_path).to eq '/users/login'

    # second, we build a current user and save!
    @user = FactoryGirl.build(:user, email: 'sendinvite@example.com')
    @user.bio = 'sending my first Invitation Token to best friend'
    @user.role = 'user'
    @user.save!
    # login_as @user
    # sign_in @user
    # sign_in(@user.email, @user.password)
    # @request.env["devise.mapping"] = Devise.mappings[:user]

    # Template ?
    # new_user_session_path(:argument => "value") # params[:argument] : access in controller
    new_user_session_path(id: @user.id) # params[:argument] : access in controller

    # 201606070830
    # visit new_user_session_path(user: @user)
    # #  ArgumentError: wrong number of arguments (given 0, expected 1..2)

=begin
[20] pry(#<RSpec::ExampleGroups::NewInvitations>)> visit new_user_session_path(@user)
ArgumentError: wrong number of arguments (given 0, expected 1..2)
from /Users/William/.rvm/gems/ruby-2.3.0@Rails4.2_visitmeet/gems/devise-4.1.0/lib/devise/test_helpers.rb:48:in `sign_in'
[21] pry(#<RSpec::ExampleGroups::NewInvitations>)> visit new_user_session_path(@user)
DEPRECATION WARNING: [Devise] Parameter sanitization through a "Devise::ParameterSanitizer#sign_in" method is deprecated and it will be removed from Devise 4.2.
Please use the `permit` method on your sanitizer `initialize` method.

  class Devise::ParameterSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      permit(:sign_in, keys: [:param1, :param2, :param3])
    end
  end
 (called from service at /Users/William/.rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0/webrick/httpserver.rb:140)
=> ""
[22] pry(#<RSpec::ExampleGroups::NewInvitations>)> visit new_user_session_path(@user)
ArgumentError: wrong number of arguments (given 0, expected 1..2)
from /Users/William/.rvm/gems/ruby-2.3.0@Rails4.2_visitmeet/gems/devise-4.1.0/lib/devise/test_helpers.rb:48:in `sign_in'
[23] pry(#<RSpec::ExampleGroups::NewInvitations>)> visit new_user_session_path(@user)
DEPRECATION WARNING: [Devise] Parameter sanitization through a "Devise::ParameterSanitizer#sign_in" method is deprecated and it will be removed from Devise 4.2.
Please use the `permit` method on your sanitizer `initialize` method.
=end

    # expect(page).to have_link 'Sign in with Github'
# binding.pry 20160607
    fill_in :user_email, with: @user.email
    fill_in :user_password, with: @user.password
    click_on 'Sign in'
    expect(page).to have_content 'Signed in successfully.'

    visit new_user_invitation_path
    expect(current_path).to eq '/users/invitation/new'
    expect(page).to be_an Capybara::Session
    expect('page').to have_content 'Send Invitation'
    expect("devise.invitations.new.header".to_s).to eq 'Send Invitation'
    expect("devise.invitations.new.submit_button".to_s).to eq 'Send an Invitation'
    expect("#{devise.invitations.new.header}").to eq 'Send Invitation'
    expect("#{devise.invitations.new.submit_button}").to eq 'Send an Invitation'
    expect(resource.class.invite_key_fields).to be_an Array
    expect(page).to has_selector?('field')
    expect(page).to has_selector?('input')
    expect(page).to has_selector?('input#field')
    expect(page).to have 'devise.invitations.new.submit_button'

    click_on 'Submit'
    expect(invitation_path(resource_name)).to eq '?'
  end
end
