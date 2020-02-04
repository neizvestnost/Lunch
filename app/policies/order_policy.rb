# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def index?
    user.lunch_admin?
  end

  def create?
    user.user?
  end
end
