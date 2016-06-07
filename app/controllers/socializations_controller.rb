# frozen_string_literal: true
# code: app/controllers/socializations_controller.rb
# test: spec/controllers/socializations_controller_spec.rb
# require 'pry'
class SocializationsController < ApplicationController
  include ActionController::Helpers
  # :load_socializable symbol stands in for module at ? TODO: find it
  before_action :load_socializable # can be commented out for testing runs

  def follow
    current_user.follow!(@socializable)
    render json: { follow: true }
  end

  def unfollow
    current_user.unfollow!(@socializable)
    render json: { follow: false }
  end

  private

  def load_socializable
    # Bishisht : research this rubocop response:
    # Do not use empty case condition, instead use an if expression.
    # Also, what is case ? and what is done with it ? below is not a case statement, is it?
    # # @socializable = case # # has been prefaced with the if statement:
    #
    # # # 1st adjustment
    # if case
    #   @socializable = case
    #                   when id = params[:user_id]
    #                     User.find(id)
    #                   else
    #                     raise ArgumentError, 'Unsupported model, params:' + params.keys.inspect
    #                   end
    # raise ActiveRecord::RecordNotFound unless @socializable
    #
    # # # 2nd adjustment
    # this code is not right
    # if case
    #   @socializable = case
    #                  when id = params[:user_id]
    #                    User.find(id)
    #                  # when params[:user_id] == nil
    #                  when params[:user_id].nil?
    #                    raise ActiveRecord::RecordNotFound unless @socializable
    # end
    # raise ArgumentError, 'Unsupported model, params:' + params.keys.inspect
  end
end

