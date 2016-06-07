# frozen_string_literal: true
# code: app/controllers/admin/users_controller.rb
# test: spec/controllers/admin/users_controller_spec.rb
# TODO: 20160605 we are missing a Strategy, I do believe, and also there are
# three methods not defined yet: authenticate, authenticated, unauthenticated devise methods
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
# require 'pry'
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
    sign_in(@user)
  end
end

RSpec.describe UsersController, :devise, js: true do
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

  describe 'allows user to see their users_profile' do
    it 'renders the user profile' do
      @user = FactoryGirl.build(:user, email: 'youare@example.com')
      @user.role = 'admin'
      @user.save!
      users = User.all
      expect(users.class).to eq User::ActiveRecord_Relation

      login_as @user
      expect(response.status).to eq 200
      expect(response).to be_success
      @request.env['devise.mapping'] = Devise.mappings[:user]
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(current_path).to eq '/users/profile'
      expect(page).to have_content('youare@example.com')
      # TODO: need to fix the message not showing : 20160523 -ko
      # expect(page).to have_content('Signed in successfully.')
    end

    it 'allows admin entrance to admin dasboard' do
      pending 'needs work on admin authenticate'
      # 20160523 : You will need to declare some strategies to be able to get Warden to
      # # actually authenticate. See the Strategies page for more information.
      # # https://github.com/hassox/warden/wiki/Strategies
      # # TODO: we have no strategies in place, we have no authenticated methods defined,
      # #  therefore it is impossible to get tests to authenticate and or post create user.
      @user = FactoryGirl.build(:user, email: 'admindash@example.com')
      @user.role = 'admin' # using Enum for roles
      @user.save!
      expect(@user.role).to eq 'admin'
      # expect(@user.signed_in?).to eq false
      # expect(@user.signed_in?).to eq true
      # sign_in a given resource by storing its keys in the session.
      # This method bypass any warden authentication callback.
      # http://www.rubydoc.info/github/plataformatec/devise/Devise/TestHelpers
      # sign_in :user, @user   # sign_in(scope, resource)
      # sign_in @user          # sign_in(resource)

      sign_in(@user) # => [[1], "$2a$04$ikm9Inm5UaHwaW8vtMv0Xu"]
      @request.env['devise.mapping'] = Devise.mappings[:user] # => the mapping
      # # # # # beginning of request env devise mappings response
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # # => #<Devise::Mapping:0x007fb16aff2b20
      # # @class_name="User",
      # # @controllers={:omniauth_callbacks=>"users/omniauth_callbacks",
      # #               :registrations=>"devise_invitable/registrations",
      # #               :sessions=>"devise/sessions",
      # #               :passwords=>"devise/passwords",
      # #               :confirmations=>"devise/confirmations",
      # #               :invitations=>"devise/invitations"
      # # },
      # # @failure_app=Devise::FailureApp,
      # # @format=nil,
      # # @klass=#<Devise::Getter:0x007fb16aff2468 @name="User">,
      # # @modules=[:database_authenticatable,
      # #           :rememberable,
      # #           :omniauthable,
      # #           :recoverable,
      # #           :registerable,
      # #           :validatable,
      # #           :confirmable,
      # #           :trackable,
      # #           :invitable
      # # ],
      # # @path="users",
      # # @path_names={:registration=>"",
      # #              :new=>"new",
      # #              :edit=>"edit",
      # #              :sign_in=>"login",
      # #              :sign_out=>"logout",
      # #              :password=>"password",
      # #              :sign_up=>"sign_up",
      # #              :cancel=>"cancel",
      # #              :confirmation=>"confirmation",
      # #              :invitation=>"invitation",
      # #              :accept=>"accept",
      # #              :remove=>"remove"
      # # },
      # # @router_name=nil,
      # # @routes=[:session,
      # #          :omniauth_callback,
      # #          :password,
      # #          :registration,
      # #          :confirmation,
      # #          :invitation
      # # ],
      # # @scoped_path="users",
      # # @sign_out_via=:delete,
      # # @singular=:user,
      # # @strategies=[:rememberable,
      # #              :database_authenticatable
      # # ],
      # # @used_helpers=[:session,
      # #                :omniauth_callback,
      # #                :password,
      # #                :registration,
      # #                :confirmation,
      # #                :invitation
      # # ],
      # # @used_routes=[:session,
      # #                :omniauth_callback,
      # #                :password,
      # #                :registration,
      # #                :confirmation,
      # #                :invitation
      # # ]
      # # >
      # # # # # end of request env devise mappings response
      # # # # # end of pry(#<RSpec::ExampleGroups::UsersController::AllowsUserToSeeTheirUsersProfile>)>

      # # # # # begin TESTING OF request env devise mappings response
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # # => #<Devise::Mapping:0x007fb16aff2b20
      expect(@request.env['HTTP_HOST']).to eq 'test.host' # => true
      expect(@request.env['rack.version']).to eq [1, 3]
      expect(@request.env['rack.input']).to be_a StringIO
      expect(@request.env['rack.errors']).to be_a StringIO
      expect(@request.env['rack.multithread']).to eq true
      expect(@request.env['rack.multiprocess']).to eq true
      expect(@request.env['rack.run_once']).to eq false
      expect(@request.env['REQUEST_METHOD']).to eq 'GET'
      expect(@request.env['SERVER_NAME']).to eq 'example.org'
      expect(@request.env['SERVER_PORT']).to eq '80'
      expect(@request.env['QUERY_STRING']).to eq ''
      expect(@request.env['rack.url_scheme']).to eq 'http'
      expect(@request.env['HTTPS']).to eq 'off'
      expect(@request.env['SCRIPT_NAME']).to eq ''
      expect(@request.env['CONTENT_LENGTH']).to eq '0'
      expect(@request.env['HTTP_HOST']).to eq 'test.host'
      expect(@request.env['REMOTE_ADDR']).to eq '0.0.0.0'
      expect(@request.env['HTTP_USER_AGENT']).to eq 'Rails Testing'
      expect(@request.env['action_dispatch.routes']).to be_an ActionDispatch::Routing::RouteSet
      expect(@request.env['action_dispatch.routes.append']).to eq nil
      expect(@request.env['action_dispatch.routes.default_url_options']).to eq nil
      expect(@request.env['action_dispatch.routes.default_url_options']).to eq nil
      expect(@request.env['action_dispatch.routes.devise_finalized']).to eq nil
      expect(@request.env['action_dispatch.routes.disable_clear_and_finalize']).to eq nil
      expect(@request.env['action_dispatch.routes.finalized']).to eq nil
      # expect(@request.env['class_name']).to eq 'User'
      # expect(@request.env['controllers']).to eq ''
      #
      # # @class_name="User",
      # # @controllers={:omniauth_callbacks=>"users/omniauth_callbacks",
      # #               :registrations=>"devise_invitable/registrations",
      # #               :sessions=>"devise/sessions",
      # # tests TODO:   :passwords=>"devise/passwords",
      # #               :confirmations=>"devise/confirmations",
      # #               :invitations=>"devise/invitations"
      # # },
      # # @failure_app=Devise::FailureApp,
      # # @format=nil,
      # # @klass=#<Devise::Getter:0x007fb16aff2468 @name="User">,
      # # @modules=[:database_authenticatable,
      # #           :rememberable,
      # #           :omniauthable,
      # #           :recoverable,
      # #           :registerable,
      # #           :validatable,
      # #           :confirmable,
      # #           :trackable,
      # #           :invitable
      # # ],
      # # @path="users",
      # # @path_names={:registration=>"",
      # #              :new=>"new",
      # #              :edit=>"edit",
      # #              :sign_in=>"login",
      # #              :sign_out=>"logout",
      # #              :password=>"password",
      # #              :sign_up=>"sign_up",
      # #              :cancel=>"cancel",
      # #              :confirmation=>"confirmation",
      # #              :invitation=>"invitation",
      # #              :accept=>"accept",
      # #              :remove=>"remove"
      # # },
      # # @router_name=nil,
      # # @routes=[:session,
      # #          :omniauth_callback,
      # #          :password,
      # #          :registration,
      # #          :confirmation,
      # #          :invitation
      # # ],
      # # @scoped_path="users",
      # # @sign_out_via=:delete,
      # # @singular=:user,
      # # @strategies=[:rememberable,
      # #              :database_authenticatable
      # # ],
      # # @used_helpers=[:session,
      # #                :omniauth_callback,
      # #                :password,
      # #                :registration,
      # #                :confirmation,
      # #                :invitation
      # # ],
      # # @used_routes=[:session,
      # #                :omniauth_callback,
      # #                :password,
      # #                :registration,
      # #                :confirmation,
      # #                :invitation
      # # ]
      # # >
      # # # # # end of request env devise mappings response
      # # # # # end of pry(#<RSpec::ExampleGroups::UsersController::AllowsUserToSeeTheirUsersProfile>)>
      #
      # 20160523 : to continue, see : https://github.com/hassox/warden/wiki/Strategies
      # TODO: 20160529 : define authenticated, and other methods
      # # also
      # # specifically, What is a Strategy
      expect(@user.valid?).to eq true
      expect(@user.validate!).to eq true

      # Warden::Manager.serialize_from_session do |id|
      #   User.get(id)
      # end
      # first try with serialize_into_session
      # ref : https://github.com/plataformatec/devise/blob/master/lib/devise/models/authenticatable.rb
      # @user.serialize_into_session(@user)
      # login_as @user

      visit '/admin'
      # # browser response: http://127.0.0.1:50884/admin
      # # Internal Server Error
      # # undefined method `paginate' for #<User::ActiveRecord_Relation:0x007fae5e9956b0>
      # # I commented out the method in the controller: 20160605
      expect(current_path).to eq '/admin'
      #
      # 20160523 : new answer for below problem
      # the authenticate, authenticated and unauthenticated methods were not defined!
      # sadly, as a tester, it took me this long to find and prove this stubborn authentication
      # failure is because Devise setup was incomplete for testing.
      # https://github.com/plataformatec/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb
      # see above ref to fix below problem : not yet done : 20160529 20160523

      # second result is a browser error, breaks on the visit
      # visit '/admin/users/admin'
      # Internal Server Error
      # # undefined method `authenticate_admin!' for #<Admin::UsersController:0x007fcf56d0ec60>
      # # Did you mean? authenticate_inviter! authenticate_user!
      #
      # first result was a modal popup : Authentication Required
      # cause probably was logging in action was missing
      # visit '/admin/users/admin'
      # need to fill in User Name and Password in the modal
      # click_on 'Cancel' # need to find a way to find the modal Cancel button
      # not sure how to do this, so during tests, i hand-click Cancel buttpm
      # back to Omniauth studying
      # expect(current_url).to match(/http\:\/\/127\.0\.0\.1\:\d+\/admin/)
    end
  end
end
