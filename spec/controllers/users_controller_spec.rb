# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:lunch_admin) { create(:lunch_admin) }
  let(:user)        { create(:user) }

  describe 'GET index' do
    it 'have status 200 if admin authorize' do
      sign_in lunch_admin
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'have status 302 if admin no authorize' do
      get :index
      expect(response).to have_http_status(302)
    end

    it 'return 403 if user has role user' do
      sign_in user
      get :index
      expect(response).to have_http_status(403)
    end
  end
end
