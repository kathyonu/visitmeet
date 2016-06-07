# frozen_string_literal: true
# code: app/views/layouts/_navigation.html.erb
# test: spec/features/visitors/navigation_spec.rb
#
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
feature 'Navigation links', :devise, js: true do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: View navigation links
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see VisitMeet, Login and other links
  scenario 'view navigation links on sign_up page' do
    visit new_user_registration_path
    expect(current_path).to eq '/users/sign_up'
    expect(page).to have_content 'VisitMeet'
    expect(page).to have_content 'Visit'
    expect(page).to have_content 'Meet'
    expect(page).to have_content 'Products'
    expect(page).to have_content 'Register to Visit & Meet'
    expect(page).to have_content 'Already have an account? Log in'
    expect(page).to have_content 'Sign in with GitHub'
    expect(page).to have_content 'Copyright © VisitMeet 2016'

    click_on 'Login'
    # TODO: research this, it is very odd -ko 20160521
    # this flips from on to the other, for no known reason
    # sometimes it is login sometimes it is sign_up
    # how can this be happening ?
    expect(current_path).to eq '/users/login'
  end

  # Scenario: View home page navigation links
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see VisitMeet, Login and other links
  scenario 'view navigation links on home page' do
    visit root_path
    expect(current_path).to eq '/'
    expect(page).to have_link 'Login'
    within '.jumbotron h2 b' do
      expect(page).to have_content 'VisitMeet'
    end

    click_on 'Login'
    expect(current_path).to eq '/users/login'
  end

  # Please do not delete, thank you  : kathyonu : 20160521
  # Scenario: Login link does not show on Login page
  #   Given I am a visitor
  #   When I click the Login link
  #   Then I arrive on the /users/sign_in page
  #   And the Login link is no longer showing
  # scenario 'users login page does not display Login link' do
  # visit new_user_session_path
  # expect(current_path).to eq '/users/login'
  # expect(page).to have_content 'About'
  # # TODO: after link duplication is repaired, reverse this next test on Login -ko : 20160521
  # # Link duplication referred to shows up best on the /users/login page : new_user_session_path
  # expect(page).to have_content 'Login'
  # expect(page).to have_content 'Sign in with Github'
  # expect(page).to have_content 'Forgot your password?'
  #  expect(page).to have_content "Didn't receive confirmation instructions?"
  #  expect(page).to have_link 'About'
  # # TODO: after link duplication is repaired, reverse this next test on Login -ko : 20160521
  #  expect(page).to have_link 'Login'
  #  expect(page).to have_link 'Sign in with Github'
  #  expect(page).to have_link 'Sign up'
  #  expect(page).to have_link 'Forgot your password?'
  #  expect(page).to have_link "Didn't receive confirmation instructions?"
  #  expect(page).to have_link 'Team'
  #  expect(page).to have_link 'Products'
  #  expect(page).to have_link 'VisitMeet'
  # end

  # TERMINAL Warning : DEPRECATION WARNING:
  # [Devise] user_omniauth_authorize_path(:github) is deprecated
  # # and it will be removed from Devise 4.2.
  # # Please use user_github_omniauth_authorize_path instead.
  scenario 'app is using user_github_omniauth_authorize_path method' do
    a = File.readlines('app/views/layouts/_navigation.html.erb')
    expect(a.class).to eq Array
    b = a.to_s
    c = b.gsub(/\\n/, ' ')
    d = c.gsub(/\\/, ' ') # DO NOT DO WHAT RUBOCOP SAYS TO DO on this line : 20160520 -ko
    # code being tested: user_github_omniauth_authorize_path(:github)
    # code location: app/views/layouts/_navigation.html.erb
    expect(d).to match(/user_github_omniauth_authorize_path/) # new
    # expect(d).to match(/user_omniauth_authorize_path/) # old
  end
end
