# frozen_string_literal: true
# code: app/controllers/users/omniauth_callbacks_controller.rb
# code: spec/support/integration_spec_helper.rb
# code: spec/rails_helper.rb 
# test: spec/features/integration_spec.rb
# test: spec/features/omniauth_spec.rb
# notes:
# ref : "http://stackoverflow.com/questions/13805604/trying-to-test-omniauth-with-rspec-capybara-failing"
module IntegrationSpecHelper
  OmniAuth.config.add_mock(
    :github, 
    {
      info: {
        username: ENV['GITHUB_TEST_USER_USERNAME'],
        password: ENV['GITHUB_TEST_USER_PASSWORD']
      }
    }
  )

  def login_with_oauth(service = :github)
    visit "/auth/#{service}"
  end
end
