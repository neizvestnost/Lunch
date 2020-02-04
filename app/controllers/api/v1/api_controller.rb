# frozen_string_literal: true

class Api::V1::ApiController < ActionController::API
  before_action :authenticate_user_by_api_token

  def current_user
    @current_user = User.find_by(api_token: request.headers['Api-Token'])
  end

  private

  def authenticate_user_by_api_token
    return if current_user&.lunch_admin?

    render_error t('errors.api.unauthenticated'), :unauthorized)
  end

  def render_error(message, status = :bad_request)
    render json: { error: message }, status: status
  end
end
