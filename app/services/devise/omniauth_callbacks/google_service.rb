# frozen_string_literal: true

class Devise::OmniauthCallbacks::GoogleService < ApplicationService
  initialize_with :params

  def call
    return user if find_user.present?

    create_user!
    LunchAdminCheckerService.call(user: user)
    user
  end

  private

  attr_reader :user

  def auth_params
    {
      email: params['info']['email'],
      name: params['info']['name'],
      provider: params['provider'],
      uid: params['uid'],
      password: Devise.friendly_token[0, 20]
    }
  end

  def find_user
    @user ||= User.find_by(
      provider: auth_params[:provider],
      uid: auth_params[:uid]
    )

    @user && generate_api_token

    @user
  end

  def create_user!
    user_form = Users::OmniauthCallbacks::GoogleOauth2Form.new(User.new, auth_params)

    user_form.save

    @user = user_form.model
  end

  def generate_api_token
    ApiTokenGeneratorService.call(user: user)
  end
end
