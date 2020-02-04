# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout 'devise'

  before_action :configure_permitted_parameters_for_sign_up, only: :create
  before_action :configure_permitted_parameters_for_edit,    only: :update

  def create
    super do |resource|
      LunchAdminCheckerService.call(user: resource) if resource.persisted?
    end
  end

  private

  def configure_permitted_parameters_for_sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end

  def configure_permitted_parameters_for_edit
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
    params.delete(:current_password)
  end

  def update_resource(resource, params)
    resource.update(params)
  end

  def after_sign_up_path_for(resource)
    redirect_paths = { User::LUNCH_ADMIN => users_path, User::USER => menus_path }
    redirect_paths[resource.role]
  end

  def after_update_path_for(_resource)
    menus_path
  end
end
