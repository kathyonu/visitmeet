# frozen_string_literal: true
# code: app/helpers/application_helper.rb
# test: spec/helpers/application_helper_spec.rb + numerous more
# setups by kathyonu, please do not remove : 20160605

=begin

this is the code being tested, from : app/helpers/application_helper.rb

module ApplicationHelper
  # `helper_method` placed in app/controllers/application_controller.rb : reference :
  # http://stackoverflow.com/questions/4081744/devise-form-within-a-different-controller
  # helper_method :resource_name, :resource_class, :resource, :devise_mapping

  # reference for next three methods
  # http://stackoverflow.com/questions/14866353/devise-sign-in-not-completing
  # ref for `admin_controller?` method : app/controllers/application_controller.rb
  # TODO: these methods needs to be tested : 20160425
  def resource_name
    @resource_name ||= if admin_controller?
                         :admin_user
                       else
                         :user
                       end
  end

  def resource
    @resource ||= resource_name.to_s.classify.constantize.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[resource_name]
  end

  # `resource_class` reference:
  # http://stackoverflow.com/questions/15348421/devise-render-sign-up-in-form-partials-elsewhere-in-code
  def resource_class
    devise_mapping.to
  end
end
=end
