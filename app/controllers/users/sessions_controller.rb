# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'devise'

  def create
    super do
      ApiTokenGeneratorService.call(user: resource) if resource.lunch_admin?
    end
  end

  def destroy
    current_user.update(api_token: nil) if current_user.lunch_admin?
    super
  end

  private

  def after_sign_in_path_for(resource)
    case resource.role
    when User::LUNCH_ADMIN
      users_path
    when User::USER
      menus_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
