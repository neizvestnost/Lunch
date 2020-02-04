# frozen_string_literal: true

class ApiTokenGeneratorService < ApplicationService
  initialize_with :user

  def call
    user.update!(api_token: generate_token) if user.lunch_admin?
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
