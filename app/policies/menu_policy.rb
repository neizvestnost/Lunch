# frozen_string_literal: true

class MenuPolicy < ApplicationPolicy
  def new?
    user.lunch_admin?
  end

  def create?
    new?
  end
end
