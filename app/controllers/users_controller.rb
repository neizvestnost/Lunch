# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend

  def index
    authorize current_user
    @pagy, @users = pagy(User.user, items: 4)

    respond_to do |format|
      format.html
      format.json { render json: { users: @users, pagy: pagy_metadata(@pagy) } }
    end
  end
end
