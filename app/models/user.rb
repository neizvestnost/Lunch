# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :trackable, omniauth_providers: %i[google_oauth2]

  enum role: {
    user: USER = 'user',
    lunch_admin: LUNCH_ADMIN = 'lunch_admin'
  }

  has_many :orders, dependent: :destroy
end
