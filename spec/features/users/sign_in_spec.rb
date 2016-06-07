# frozen_string_literal: true
# code: app/controllers/visitors_controller_spec.rb
# test: spec/features/visitors/sign_in_spec.rb
# 
require 'pry' # uncomment for testing use
#
# # # NOTE ON : include Devise::TestHelpers
# # ref : http://stackoverflow.com/questions/27284657/undefined-method-env-for-nilnilclass-in-setup-controller-for-warden-error
# # These helpers are not going to work for integration tests driven by Capybara or Webrat.
# # They are meant to be used with functional (controller) tests only.
# # It is undesirable even to include Devise::TestHelpers during integration tests.
# # Instead, fill in the form or explicitly set the user in session
# # Sign in / Log in Test Version 1
# # https://github.com/plataformatec/devise/
# # Four Devise test_helper methods available
# # sign_in :user, @user # sign_in(scope, resource)
# # sign_in @user        # sign_in(resource)
# # sign_out :user       # sign_out(scope)
# # sign_out @user       # sign_out(resource)
#
# @request.env["devise.mapping"] = Devise.mappings[:user]
# sign_in @user
#
# use above or below, but not both
#
# # Sign in / Log in Test Version 2
# # signin method in support/helpers/sessions_helper.rb
# # signin(email, password) # template
# @request.env["devise.mapping"] = Devise.mappings[:admin]
# signin(@user.email, @user.password)
# # #
# see note above regarding Devise::TestHelpers
# include Devise::TestHelpers
#
include Selectors
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :devise, js: true do
  before(:each) do
    @user = FactoryGirl.build(:user)
    visit root_path
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'user cannot sign in if not registered' do # passes tests
    @user.save!
    expect(current_path).to eq '/'

    email = 'nononehere@example.com'
    password = 'noonehere'

    signin(email, password)
    expect(page).to have_content 'Invalid Email or password.'
    # TODO: FIX
    # expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'email'

    visit '/users/profile'
    expect(page).not_to have_content 'noonehere@example.com.'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content I18n.t 'devise.failure.unauthenticated', authentication_keys: 'email'
  end

  # Scenario: User can sign in with valid credentials
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  scenario 'user can sign in with valid credentials' do
    @user = FactoryGirl.create(:user, email: 'cansignin@example.com')
    login_as @user
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    # signin(user.email, user.password)
    expect(current_path).to eq '/'
    expect(page).to have_content 'Hello World'
    expect(page).to have_content 'Paths are made by walking.'
    # TODO: get next tests working again:
    # 20160521 : both tests below still not passing
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    visit '/users/profile'
    expect(current_path).to eq '/users/profile'
    expect(page).to have_content @user.email.to_s
    expect(page).to have_content 'cansignin@example.com'
    # TODO: get next tests working again:
    # 20160509 : both tests still not passing : 20160521
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    # @user.email = 'neverinvalid@example.com'
    # notice we do not save the user's email change
    # login_as @user
    signin('neverinvalid@example.com', @user.password)
    expect(current_path).to eq '/users/login'

    visit 'users/profile'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content I18n.t 'devise.failure.unauthenticated', authentication_keys: 'email'
    # expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end

  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot sign in with wrong password' do
    # @user.password = 'nevervalid'
    @user.save!
    # login_as @user
    signin(@user.email, 'nevervalid')
    expect(page).to have_content 'Invalid Email or password.'
    # TODO: FIX
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'

    visit 'users/profile'
    # visit users_profile_path
    # signin(@user.email, @user.password)
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    # TODO: get this next text working again:
    # 20160509 : are both tests below now passing : no
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content I18n.t 'devise.failure.unauthenticated', authentication_keys: 'email'
  end

  scenario 'user sign_in page exists' do
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'
  end

  scenario 'user can choose to sign in with github credentials' do
    pending 'needs more work to pass the full sign in'
    # this user tries to sign in but cannot
    @user.email = 'notgithubuser@example.com'
    @user.save!
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Github'
    expect(page).to have_link 'Sign in with Github'

    fill_in :user_email, with: @user.email
    fill_in :user_password, with: @user.password
    click_on 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
    # 20160604 : works and arrives at '/' with 'Signed in successfully.'
    # ToDone: Deprecation notice WAS given in Terminal at this point
    # DEPRECATION WARNING: [Devise] user_omniauth_authorize_path(:github) is deprecated
    # # and it will be removed from Devise 4.2
    # FIXED: with new authorize_path command name -ko
    # expect(page).to have_content 'Invalid Email or password'
    # expect(page).to have_content 'Incorrect username or password'

    # user registers with github and has new email
    @user = FactoryGirl.create(:user, email: 'githubuser@example.com')
    @user.name = ENV['GITHUB_OMNIAUTH_TEST_USERNAME']
    @user.password = ENV['GITHUB_OMNIAUTH_TEST_PASSWORD']
    @user.save!
    visit '/'
    expect(page).to have_link 'Sign in with Github'

    click_on 'Sign in with Github'
    save_and_open_page
    # INFO -- omniauth: (github) Request phase initiated.
    # # => "ok"
    expect(page).to have_content 'Username or email address'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'New to GitHub? Create an account.'
    expect(page).to have_selector('.auth-form-body')
binding.pry
    fill_in 'login_field', with: @user.name
    # response is "" : view shows address entered
    fill_in 'password', with: @user.password
    # response is "" : view shows password entered with asterisks showing
    click_on 'Sign in'
    # => "ok"
    expect(page).to have_content 'Incorrect username or password.'
    expect(page.find('#login_field').value).to have_content ENV['GITHUB_OMNIAUTH_TEST_USERNAME']
    expect(page.find('#password').value).to have_content ENV['GITHUB_OMNIAUTH_TEST_PASSWORD']
    # 201605?? : test passes up to this point, we have no valid user or password for test sign in
    # 20160605 : test passes up to this point, we now have a valid user and password for test sign in

    # NOTE: when the click_on occurs, the app is expecting to see:
    # :github, ENV['OMNIAUTH_APP_ID'], ENV['OMNIAUTH_APP_SECRET'], scope: 'user,public_repo'
    #
    # # #
    # from `rake routes`
    #                  Prefix |   Verb   | URI Pattern                     | Controller#Action
    # user_omniauth_authorize | GET|POST | /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback  | GET|POST | /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    # # #
    # # click_on('Sign in with Github')
    # #  ActionController::RoutingError: # 20160522: this no longer happens
    # #   uninitialized constant Login
    # #  ?????????????????????????????? 20160425 where'd this come from ? -ko
    # # Start looking where the link is, the new_user_session_path page ! -ko
    # # TODO: 20160509 : 20160522 still UNFINISHED
    #
    # Second result, not sure what changed:
    # click_on('Sign in with Github')
    # I, [2016-04-19T08:01:28.907730 #25903]  INFO -- omniauth: (github) \
    # # Request phase initiated.
    # # ActionController::RoutingError: uninitialized constant Login << error no longer occuring
    #
    # First result:
    # click_on('Sign in with Github')
    # ActionController::RoutingError:
    # # No route matches [GET] "/login/oauth/authorize" << error no longer occuring
    #
    # first try
    # visit user_omniauth_authorize_path
    # # visit user_omniauth_authorize_path
    # # ActionController::UrlGenerationError:
    # #  No route matches {:action=>"passthru",
    # #                    :controller=>"users/omniauth_callbacks"
    # #                   } missing required keys: [:provider]
    #
    # second try
    # visit user_omniauth_authorize_path(:github)
    # # visit user_omniauth_authorize_path(:github)
    # # I, [2016-04-19T07:26:12.014027 #25537]  INFO -- omniauth: (github) \
    # #  Request phase initiated.
    # #  ActionController::RoutingError: uninitialized constant Login << no longer an error
    #
    # new error is the deprecation notice on the use of user_omniauth_authorize_path(:github)
    # new method given is : user_github_omniauth_authorize_path
    # this has not yet been incorporated : 20160522 -ko
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'is successful, user can access profile' do
    @user.email = 'accessprofile@example.com'
    @user.role = 'admin'
    @user.save!
    login_as @user
    visit '/users/profile'
    expect(current_path).to eq users_profile_path
    expect(current_path).to eq '/users/profile'
  end

  scenario 'user can click remember-me sign-in option' do
    @user.email = 'rememberme@example.com'
    @user.role = 'user'
    @user.save!
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'

    fill_in :user_email, with: @user.email
    fill_in :user_password, with: @user.password
    expect(find(:css, '#user_remember_me').set(true)).to eq 'ok'
    # expect(find(:css, '#user_remember_me').set(false)).to eq 'ok' # passes

    click_on 'Sign up'
    @user = User.last
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    expect(current_path).to eq '/'
    expect(User.last.remember_me).to eq 0
  end

  scenario 'user signing in should not see "not found"' do
    @user.email = 'correctemail@example.com'
    @user.role = 'user'
    @user.save!
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'

    fill_in :user_email, with: @user.email
    fill_in :user_password, with: 'incorrectemail@example.com'
    click_on 'Sign up'
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Please review the problems below:'
    expect(page).to have_content 'not found'

    fill_in :user_email, with: @user.email
    fill_in :user_password, with: @user.email
    click_on 'Sign up'
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    expect(current_path).to eq '/'
  end

  scenario 'password reset link is emailed to user who forgets password' do
    @user.email = 'forgottenpassword@example.com'
    @user.role = 'user'
    @user.save!
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'
    expect(page).to have_content ''
  end

  scenario 'user visits users/password page receives link to reset password' do
    @user.email = 'forgottenpassword@example.com'
    @user.role = 'user'
    @user.save!
    visit new_user_session_path
    click_on 'Forgot your password?'
    expect(current_path).to eq '/users/password'

    fill_in :user_email, with: @user.email
    click_on 'Send me reset password instructions'
    # testing browser response:
    expect(response.status).to eq 'ok'
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    # TODO: add devise verification on message for translation purposes
    # # # test server response upon the click_on, showing below:
    #
    # Started POST "/users/password" for ::1 at 2016-06-07 11:54:30 -0700
    # ActiveRecord::SchemaMigration Load (0.4ms)  SELECT "schema_migrations".* FROM "schema_migrations"
    # Processing by Devise::PasswordsController#create as HTML
    # Parameters: {"utf8"=>"✓", "authenticity_token"=>"4WBiRJxbC0jA8bw6yehQRT+rCu52DsUhY1XbA4gRgdvWl8LJXkmFUADxfbV0wPPpeFStDwRiWFHLkBDckDvOeg==", "user"=>{"email"=>"user@example.com"}, "commit"=>"Send me reset password instructions"}
    # User Load (0.7ms)  SELECT  "users".* FROM "users" WHERE "users"."email" = $1  ORDER BY "users"."id" ASC LIMIT 1  [["email", "user@example.com"]]
    # User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."reset_password_token" = $1  ORDER BY "users"."id" ASC LIMIT 1  [["reset_password_token", "63c723a655b5772621a0d8a098f93892054d66d0d2905aeb38515da4c618a160"]]
    # (0.1ms)  BEGIN
    # SQL (28.3ms)  UPDATE "users" SET "reset_password_token" = $1, "reset_password_sent_at" = $2, "updated_at" = $3 WHERE "users"."id" = $4  [["reset_password_token", "63c723a655b5772621a0d8a098f93892054d66d0d2905aeb38515da4c618a160"], ["reset_password_sent_at", "2016-06-07 18:54:32.166585"], ["updated_at", "2016-06-07 18:54:32.167526"], ["id", 1]]
    # (0.5ms)  COMMIT
    # Rendered devise/mailer/reset_password_instructions.html.erb (36.0ms)
    #
    # Devise::Mailer#reset_password_instructions: processed outbound mail in 336.7ms
    #
    # Sent mail to user@example.com (1627.2ms)
    # Date: Tue, 07 Jun 2016 11:54:32 -0700
    # From: Bishisht Bhatta <bhattabishisht@gmail.com>
    # Reply-To: Bishisht Bhatta <bhattabishisht@gmail.com>
    # To: user@example.com
    # Message-ID: <5757186890f68_5f6b3fc686f27f7441077@will-i-am.local.mail>
    # Subject: Reset password instructions
    # Mime-Version: 1.0
    # Content-Type: text/html;
    #  charset=UTF-8
    # Content-Transfer-Encoding: 7bit
    # 
    # <p>Hello user@example.com!</p>
    # 
    # <p>Someone has requested a link to change your password. You can do this through the link below.</p>
    # 
    # <p><a href="http://localhost:3000/users/password/edit?reset_password_token=86vz2XxctieQDZij6TYT">Change my password</a></p>
    # 
    # <p>If you didn't request this, please ignore this email.</p>
    # <p>Your password won't change until you access the link above and create a new one.</p>
    # 
    # Redirected to http://localhost:3000/users/login
    # Completed 302 Found in 3926ms (ActiveRecord: 34.4ms)
    # 
    # 
    # Started GET "/users/login" for ::1 at 2016-06-07 11:54:36 -0700
    # Processing by Devise::SessionsController#new as HTML
    #   Rendered devise/shared/_links.html.erb (1.6ms)
    #   Rendered devise/sessions/new.html.erb within layouts/application (564.5ms)
    #   Rendered layouts/_navigation.html.erb (1.6ms)
    #   Rendered layouts/_messages.html.slim (22.3ms)
    #   Rendered layouts/_footer.html.erb (0.4ms)
    # Completed 200 OK in 7329ms (Views: 7327.6ms | ActiveRecord: 0.0ms)
    # # #

    # TODO: now the job is to learn how to email test the above response, perhaps using the email_spec gem ?
    # anyone want to tackle this ? : 20160607 -kathyonu
  end
end
