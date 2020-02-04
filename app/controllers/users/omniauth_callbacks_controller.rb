# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def google_oauth2
    @user = Devise::OmniauthCallbacks::GoogleService.call(params: request.env['omniauth.auth'])

    return redirect_to new_user_session_path unless @user.present?

    sign_in(:user, @user)
    redirect_to after_sign_in_path_for(@user)
  end
end
