# frozen_string_literal: true
# code: app/helpers/admin/application_helper.rb
# test: spec/helpers/admin/application_helper_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
module Admin
  # Devise resource methods
  module ApplicationHelper
    # `helper_method` placed in app/controllers/application_controller.rb : reference :
    # http://stackoverflow.com/questions/4081744/devise-form-within-a-different-controller
    # helper_method :resource_name, :resource_class, :resource, :devise_mapping

    # reference for next three methods
    # http://stackoverflow.com/questions/14866353/devise-sign-in-not-completing
    # also see admin_controller? method in app/controllers/application_controller.rb
    def resource_name
      @resource_name ||= if admin_controller?
                           :admin_user
                         else
                           :user
                         end
    end # rubocop passes the format above

    def resource
      @resource ||= resource_name.to_s.classify.constantize.new
      # @resource ||= User.new : old ?  ^^ new ??
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[resource_name]
      # @devise_mapping ||= Devise.mappings[:user] : old ?  ^^ new ?
    end

    # resource_class reference:
    # http://stackoverflow.com/questions/15348421/devise-render-sign-up-in-form-partials-elsewhere-in-code
    def resource_class
      devise_mapping.to
    end
  end
end
