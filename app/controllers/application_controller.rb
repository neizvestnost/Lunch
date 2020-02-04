# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def render_error(form)
    render json: form.errors.full_messages.join(', ')
  end

  private

  def user_not_authorized
    render(template: 'errors/403', status: :forbidden)
  end
end
