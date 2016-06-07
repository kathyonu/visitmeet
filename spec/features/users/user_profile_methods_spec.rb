# frozen_string_literal: true
# code: app/controllers/users_controller.rb
# code: app/models/user.rb
# test: spec/features/users/user_profile_methods_spec.rb
# refs: Documents/visitmeet-user-profile-methods-sorted.txt fully contained below
# 20160606 refound this ..
# # from months and months and mothy months ago ..
# # spec/features/users/user_show_spec.rb test shows this up ..
#
require 'pry' # uncomment for testing use
# include Selectors
# include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!

# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
# feature ' User Sign in', :devise, js: true do
feature ' User Sign in', js: true do
  scenario 'admins can see other user profiles' do
    if user = User.find_by_email('profilemethods@example.com')
      @user = user
    else
      @user = FactoryGirl.build(:user, email: 'profilemethods@example.com')
      @user.password = 'changemesomeday'
      @user.password_confirmation = 'changemesomeday'
      @user.role = 'admin'
      @user.bio = 'a short one'
      @user.save!
      @user_profile_methods = @user.profile.methods.sort
    end
    visit root_path
    expect(current_path).to eq '/'

    visit user_session_path # browser address : http://127.0.0.1:65374/users/login
    expect(current_path).to eq '/users/login'

    fill_in :user_email, with: @user.email
    fill_in :user_password, with: @user.password
    # fill_in :user_email, with: 'myownprofile@example.com'
    # fill_in :user_password, with: 'please123'
    click_on 'Sign in'
    # visit users_profile_path # failing on 20160417
    # # browser window is showing: Internal Server Error
    # #  undefined method `bio' for nil:NilClass
    # # DATE LOST: bio now works, Bishisht added column to db : rock on
    # expect(visit users_profile_path).not_to raise_error(NoMethodError)
    visit users_profile_path
    expect(current_path).to eq '/users/profile'
    # pry ..
    # user = FactoryGirl.build(:user, email: 'iam@example.com')
    # user.role = 'admin'
    # user.save!
    # user.bio
    # user.profile
    # # Profile Load (24.7ms) \
    # # @ SELECT  "profiles".* FROM "profiles" WHERE "profiles"."user_id" = $1 LIMIT 1 \
    # # ["user_id", 2]]
    #
  end

  scenario 'user profile class method test' do
    expect(@user_profile_methods.class).to be_an NilClass

    user_profile = @user_profile_methods.to_a
    expect(@user_profile.class).to be_an Array
  end

    scenario 'user profile exclam method test' do
      expect(@user_profile.shift).to eq ':!'
    end

    scenario 'user profile "name this" method test' do
      expect(@user_profile.shift).to eq ':!~'
    end

  scenario 'user profile AND method test' do
    expect(@user_profile.shift).to eq ':&'
  end

  scenario 'user profile greater-than, equal-to, or less-than method test' do
    expect(@user_profile.shift).to eq ':<=>'
  end

  scenario 'user profile equality? method test' do
    expect(@user_profile.shift).to eq ':=='
  end

  scenario 'user profile case equality? method test' do
    expect(@user_profile.shift).to eq ':==='
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':=~'
  end

  scenario 'user profile "name this" method test' do
    pending 'regular expression statement for beginning of line'
    expect(@user_profile.shift).to eq ':^'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':__binding__'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':__id__'
  end

  scenario 'user profile "name this email?" method test' do
    expect(@user_profile.shift).to eq ':__send__'
  end

  scenario 'user profile "name this code backtick" method test' do
    expect(@user_profile.shift).to eq ":`"
  end

  scenario 'user profile acts_like? method test' do
    expect(@user_profile.shift).to eq ':acts_like?'
    expect(user.acts_like?(User)).to eq true
  end

  scenario 'user profile as_json method test' do
    expect(@user_profile.shift).to eq ':as_json'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':blank?'
    expect(user.profile.blank?).to eq false
  end

  scenario 'user profile byebug method test' do
    expect(@user_profile.shift).to eq ':byebug'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':capture'
  end

  # moved to top, first test, before converting to array
  # describe 'that' do
  # #scenario 'user profile class method test' do
  # #    expect(@user_profile.shift).to eq ':class'
  # #    expect(user.profile.class).to eq Object
  # #  end
  # end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':class_eval'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':clone'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':concern'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':debugger'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':deep_dup'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':define_singleton_method'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':display'
    expect(User.last.display).to be JSON
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':dup'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':duplicable?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':enable_warnings'
  end

  scenario 'user profile enum_for method test' do
    expect(@user_profile.shift).to eq ':enum_for'
    expect(User.last.role.enum_for(:admin)).to eq 1
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':eql?'
  end

  scenario 'user profile equal? method test' do
    expect(@user_profile.shift).to eq ':equal?'

    user1 = User.first
    user2 = User.last
    expect(user1.id.equal?(user2.id)).to eq true
  end

  scenario 'user profile extend method test' do
    # include a NamedModule, and then extend the Object being processed:
    # # @user = User.first
    # # @user.extend NamedModule
    # # @user.use_named_module_method
    expect(@user_profile.shift).to eq ':extend'
  end

  scenario 'user.profile.freeze method test' do
    expect(@user_profile.shift).to eq ':freeze'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':frozen?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':gem'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':hash'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':html_safe?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':in?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':inspect'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_eval'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_exec'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_of?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_values'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_variable_defined?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_variable_get'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_variable_names'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_variable_set'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':instance_variables'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':is_a?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':itself'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':kind_of?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':load_dependency'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':method'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':methods'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':nil?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':object_id'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':presence'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':presence_in'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':present?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':pretty_inspect'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':pretty_print'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':pretty_print_cycle'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':pretty_print_inspect'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':pretty_print_instance_variables'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':private_methods'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':protected_methods'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':pry'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':psych_to_yaml'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':public_method'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':public_methods'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':public_send'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':quietly'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':rationalize'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':remove_instance_variable'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':require_dependency'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':require_or_load'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':respond_to?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':send'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':silence'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':silence_stderr'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':silence_stream'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':silence_warnings'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':singleton_class'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':singleton_method'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':singleton_methods'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':suppress'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':suppress_warnings'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':taint'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':tainted?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':tap'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_a'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_c'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_enum'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_f'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_h'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_i'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_json'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_json_with_active_support_encoder'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_json_without_active_support_encoder'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_param'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_query'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_r'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_s'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_yaml'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':to_yaml_properties'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':trust'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':try'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':try!'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':unloadable'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':untaint'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':untrust'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':untrusted?'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':with_options'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':with_warnings'
  end

  scenario 'user profile "name this" method test' do
    expect(@user_profile.shift).to eq ':|'
  end

=begin
[14] pry(main)> user.profile.methods.sort
# => [:!,
 :!=,
 :!~,
 :&,
 :<=>,
 :==,
 :===,
 :=~,
 :^,
 :__binding__,
 :__id__,
 :__send__,
 :`,
 :acts_like?,
 :as_json,
 :blank?,
 :byebug,
 :capture,
 :class,
 :class_eval,
 :clone,
 :concern,
 :debugger,
 :deep_dup,
 :define_singleton_method,
 :display,
 :dup,
 :duplicable?,
 :enable_warnings,
 :enum_for,
 :eql?,
 :equal?,
 :extend,
 :freeze,
 :frozen?,
 :gem,
 :hash,
 :html_safe?,
 :in?,
 :inspect,
 :instance_eval,
 :instance_exec,
 :instance_of?,
 :instance_values,
 :instance_variable_defined?,
 :instance_variable_get,
 :instance_variable_names,
 :instance_variable_set,
 :instance_variables,
 :is_a?,
 :itself,
 :kind_of?,
 :load_dependency,
 :method,
 :methods,
 :nil?,
 :object_id,
 :presence,
 :presence_in,
 :present?,
 :pretty_inspect,
 :pretty_print,
 :pretty_print_cycle,
 :pretty_print_inspect,
 :pretty_print_instance_variables,
 :private_methods,
 :protected_methods,
 :pry,
 :psych_to_yaml,
 :public_method,
 :public_methods,
 :public_send,
 :quietly,
 :rationalize,
 :remove_instance_variable,
 :require_dependency,
 :require_or_load,
 :respond_to?,
 :send,
 :silence,
 :silence_stderr,
 :silence_stream,
 :silence_warnings,
 :singleton_class,
 :singleton_method,
 :singleton_methods,
 :suppress,
 :suppress_warnings,
 :taint,
 :tainted?,
 :tap,
 :to_a,
 :to_c,
 :to_enum,
 :to_f,
 :to_h,
 :to_i,
 :to_json,
 :to_json_with_active_support_encoder,
 :to_json_without_active_support_encoder,
 :to_param,
 :to_query,
 :to_r,
 :to_s,
 :to_yaml,
 :to_yaml_properties,
 :trust,
 :try,
 :try!,
 :unloadable,
 :untaint,
 :untrust,
 :untrusted?,
 :with_options,
 :with_warnings,
 :|]
(END)
=end
end
