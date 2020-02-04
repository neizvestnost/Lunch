# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.lunch_admin?
  end
end
