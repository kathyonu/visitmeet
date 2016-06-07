# frozen_string_literal: true
# code: app/controllers/socializations_controller.rb
# test: spec/controllers/socializations_controller_spec.rb
#

# These are Functional Tests for Rail Controllers testing the various actions of a single controller
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view
#
# https://www.relishapp.com/rspec/rspec-rails/docs/matchers/redirect-to-matcher
# The `redirect_to` matcher is used to specify that a request redirects to a given
# template or action. It delegates to assert_redirected_to.
#
# The `redirect_to` matcher is available in controller specs (spec/controllers)
# The `redirect_to` matcher is available in request specs (spec/requests)
include Devise::TestHelpers
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do
  Warden::Manager.serialize_into_session do |user|
    @user = FactoryGirl.build(:user, email: 'tester@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    # sign_in a given resource by storing its keys in the session.
    # This method bypass any warden authentication callback.
    # http://www.rubydoc.info/github/plataformatec/devise/Devise/TestHelpers
    # sign_in :user, @user   # sign_in(scope, resource)
    # sign_in @user          # sign_in(resource)
    # see app/controllers/users_controller.rb for full reference and methods
    sign_in(@user)
  end
end

RSpec.describe SocializationsController, :devise, js: true do
  render_views # this little line is priceless in controller tests -ko

  before(:each) do
    # @user = FactoryGirl.build(:user, email: 'tester@example.com')
    # @user.role = 'admin' # using Enum for roles
    # @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'user to socialize' do
    it 'allows one member to follow another' do
      pending 'write some code'
    end

    it 'allows one member to unfollow another' do
      pending 'write some code'
    end

    it 'raises exception if member is not sociaizable' do
      pending 'write some code'
    end


    it 'raises exception if member is not sociaizable' do
      pending 'write some code'
      # NOTE: this is code being tested, and i suspect it is not correct
      # only because i do not fully understand this code's every term yet : 20160603 -ko
      # # if case
      # #   @socializable = case
      # #   # when id = params[:user_id]
      # #     User.find(id)
      # #   else
      # #     raise ArgumentError, 'Unsupported model, params:' + params.keys.inspect
      # #   end
      # # end
      # # # raise ActiveRecord::RecordNotFound unless @socializable
      # source: app/controllers/socializations_controller.rb

      it 'tests the `include ActionController::Helpers` statement methods' do
        # TODO: verify again no need to test the `include ActionController::Helpers` statement
      end
      
      # where does the load_socializable action come from, what does it do ?
      # is the load_socializable action able to result in potential database changes ? y n ?
      it 'tests the `before_action :load_socializable` loading' do
        pending 'write a test for this `load_socializable` puppy'
      end
    end
  end
end
