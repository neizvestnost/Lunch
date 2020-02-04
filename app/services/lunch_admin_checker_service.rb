# frozen_string_literal: true

class LunchAdminCheckerService < ApplicationService
  initialize_with :user

  def call
    return unless User.limit(2).count == 1

    user.update!(role: User::LUNCH_ADMIN)
    ApiTokenGeneratorService.call(user: user)
  end
end
