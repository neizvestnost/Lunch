# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }
  let(:lunch_admin) { create(:lunch_admin) }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create' do
    it 'create session for user if all fields are valid' do
      post :create, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
      expect(response).to have_http_status(302)
      expect(controller.current_user.email).to eq(user.email)
      expect(controller.current_user.api_token).to eq('')
    end

    it "doesn't create session for user if some field invalid" do
      post :create, params: {
        user: {
          email: user.email,
          password: '123'
        }
      }
      expect(controller.current_user).to eq(nil)
    end

    it 'create session for lunch_admin and generate api_token' do
      post :create, params: {
        user: {
          email: lunch_admin.email,
          password: lunch_admin.password
        }
      }
      expect(response).to have_http_status(302)
      expect(controller.current_user.email).to eq(lunch_admin.email)
      expect(controller.current_user.api_token).not_to eq(nil)
    end
  end

  describe 'DELETE destroy' do
    it 'delete session for lunch_admin and delete api token' do
      sign_in lunch_admin
      delete :destroy, params: {
        id: lunch_admin.id
      }
      expect(controller.current_user).to eq(nil)
      expect(User.last.api_token).to eq(nil)
    end

    it 'delete session for user' do
      sign_in user
      delete :destroy, params: {
        id: user.id
      }
      expect(controller.current_user).to eq(nil)
    end
  end
end
