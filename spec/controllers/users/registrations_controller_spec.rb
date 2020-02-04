# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user) { create(:user) }
  let(:lunch_admin) { create(:lunch_admin) }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create' do
    it 'registrate user if all fields are valid and make the first user as lunch_admin' do
      post :create, params: {
        user: {
          email: Faker::Internet.email,
          password: '123456'
        }
      }
      expect(response).to have_http_status(302)
      expect(controller.current_user.role).to eq('lunch_admin')
      expect(controller.current_user.api_token).not_to eq(nil)
    end

    it "don't registrate user if some field is invalid" do
      post :create, params: {
        user: {
          email: Faker::Internet.email,
          password: '123'
        }
      }
      expect(controller.current_user).to eq(nil)
      expect(User.count).to eq(0)
    end

    it 'registrate user with role user if users are presence' do
      lunch_admin
      post :create, params: {
        user: {
          email: Faker::Internet.email,
          password: '123456'
        }
      }
      expect(response).to have_http_status(302)
      expect(User.count).to eq(2)
      expect(User.last.role).to eq('user')
    end
  end
end
