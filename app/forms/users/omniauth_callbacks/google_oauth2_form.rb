# frozen_string_literal: true

class Users::OmniauthCallbacks::GoogleOauth2Form < Reform::Form
  property :email
  property :provider
  property :uid
  property :name
  property :password

  def save
    return false unless valid?

    super
  end
end
