# frozen_string_literal: true
# code: app/controllers/users/omniauth_callbacks_controller.rb
# test: spec/config/oauth_spec.rb
# route: get '/login/oauth/authorize'
# 
require 'pry'
# include Selectors
#include Warden::Test::Helpers
#Warden.test_mode!

# Feature: User uses github oauth to sign in
#   As a user
#   I want to visit sign in using github credentials
#   So I can see my personal account data
# feature 'User oauth with github', type: :feature, js: true do
feature 'User oauth with github' do
  after(:each) do
 #   Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in with github credentials
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'is successful using github credentials to access profile' do
    pending 'shows as passing, see notes below, as it is not'
    githubuser = FactoryGirl.build(:user, email: 'accessprofile@example.com')
    githubuser.provider = 'github'
    githubuser.role = 'admin'
    githubuser.save!
    expect(User.last.id).to eq 1
    expect(githubuser.sign_in_count?).to eq false

    # post :create, user: user_omniauth_authorize_path(:github)
    # TODO: need more study on how to do this - ko 20160422 Happy EARTH HEART Day
    # Templates from $ bundle exec rake routes
    # user_omniauth_authorize GET|POST /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback GET|POST  /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    # solution : we are missing this callback page ???? ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    # further data: on the home_page_spec.rb, this occurs:
    # error occuring : 20160523 : browser address shows:
    # # http://visitmeet.herokuapp.com/auth/github/callback?error=redirect_uri_mismatch&error_description=The+redirect_uri+MUST+match+the+registered+callback+URL+for+this+application.&error_uri=https%3A%2F%2Fdeveloper.github.com%2Fv3%2Foauth%2F%23redirect-uri-mismatch&state=738e098523c902811550a13eadea038ea3c41e303350fd65
    # # TODO: it appears we are missing this page, do more research on this

    visit '/'
    expect(page).to have_content 'Sign in with Github'

    # # 
    click_on 'Sign in with Github'
    # # # second response:
    # click_on 'Sign in with Github'
    # # ActionController::RoutingError:
    # #   uninitialized constant Login
    # # ./spec/features/omniauth_spec.rb:13:in `block (2 levels) in <top (required)>'
    # # ------------------
    # # --- Caused by: ---
    # # NameError:
    # #   uninitialized constant Login
    # #   /Users/William/.rvm/gems/ruby-2.3.0@Rails4.2_visitmeet/gems/omniauth-1.3.1/lib/omniauth/strategy.rb:186:in `call!'
    #
    # # # first response:
    # save_and_open_page : there is a delay in css being applied,
    # # resulting in two windows showing in succession : TODO: fix it : 20160523
    #
    # there was a redirect occuring here because our password was wrong
    # i changed the data to the correct keys located in config/local_env.yml
    # also notice the response show below, with pry, allows for no more input
    # i believe what is happening here is it is waiting for our callback address/page
    # to respond. I HAVE NO IDEA yet, if that page is set up by us, or Github,
    # nor do I know if it even exists. Here is the click_on response:
    #
    # click_on 'Sign in with Github'
    # # [1] pry(#<RSpec::ExampleGroups::UserOauthWithGithub>)> \
    # # # I, [2016-05-11T20:42:29.347317 #26426]  INFO -- omniauth: (github) Request phase initiated.
    # # => "ok"
    # # [2] pry(#<RSpec::ExampleGroups::UserOauthWithGithub>)> \
    # # # I, [2016-05-11T20:42:29.855076 #26426]  INFO -- omniauth: (github) Request phase initiated.
    # expect(current_url).to match(/github/)

    fill_in :login_field, with: ENV['GITHUB_TEST_USER_EMAIL']
    fill_in :password, with: ENV['GITHUB_TEST_USER_PASSWORD']
    click_on 'Sign in'

    # first response, before we entered GITHUB_TEST_USER_EMAIL and password
    # and before we fixed the DEPRECATION notice on the omniauth call method.
    # https://github.com/login/oauth/authorize?client_id=97ef5b4212154f75e8f6&redirect_uri=http%3A%2F%2F127.0.0.1%3A57633%2Fusers%2Fauth%2Fgithub%2Fcallback&response_type=code&scope=user%2Cpublic_repo&state=738e098523c902811550a13eadea038ea3c41e303350fd65
    # # BROWSER IS SHOWING:
    # # The page you were looking for doesn't exist.
    # #  You may have mistyped the address or the page may have moved.
    # #  If you are the application owner check the logs for more information.

    # current_path test passes, with message
    expect(current_path).to eq '/session'
    expect(page).to have_content 'Incorrect username or password.'
    # save_and_open_page # uncomment to see actual result, a failure
    # Bishisht: EVEN THOUGH THIS TEST PASSES, it is not a pass,
    # # and it is incomplete as this is a two step process, actually
    # # more, and we only appear to have the first step passing.
    # # - kathyonu : 20160511

    # visit '/users/profile'
    # expect(current_path).to eq '/users/profile'
  end

  it 'are my notes on how to finish prior test by kathyonu' do
    expect(2 + 2).to eq 4
    # # user_omniauth_authorize GET|POST /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # # user_omniauth_callback  GET|POST /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    #
    # # user_omniauth_authorize GET|POST
    # get : user_omniauth_authorize
    # # or
    # visit '/users/auth/:provider(:github)'
    #
    # # /users/auth/:action/callback(.:format)
    # # users/omniauth_callbacks#(?-mix:github)
    # get :user_omniauth_callbacks_path
    #
    # `passthru` is a Devise method that does this :
    # # render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
