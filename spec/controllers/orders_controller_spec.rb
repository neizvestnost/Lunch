# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:lunch_admin) { create(:lunch_admin) }
  let(:user)        { create(:user) }
  let(:menu)        { create(:menu) }

  describe 'GET index' do
    it 'have status 200 if lunch_admin authorize' do
      sign_in lunch_admin
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'have status 200 if day passed' do
      sign_in lunch_admin
      get :index, params: { day: 'monday' }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'have status 403 if user authorize' do
      sign_in user
      get :index
      expect(response).to have_http_status(403)
    end

    it 'have status 302 if user unauthorize' do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST create' do
    it 'have status 204 if user create order' do
      sign_in user
      post :create, params: {
        order: {
          appetizer_dish_id: menu.id,
          main_dish_id: menu.id,
          drink_dish_id: menu.id,
          user: user,
          blank: false
        }
      }
      expect(response).to have_http_status(204)
      expect(Order.all.count).to eq(1)
    end

    it 'don`t create order if order blank' do
      sign_in user
      post :create, params: {
        order: {
          appetizer_dish_id: nil,
          main_dish_id: nil,
          drink_dish_id: nil,
          user: user,
          blank: true
        }
      }
      expect(Order.all).to eq([])
    end

    it 'have status 403 if lunch_admin create order' do
      sign_in lunch_admin
      post :create, params: {
        order: {
          appetizer_dish_id: menu.id,
          main_dish_id: menu.id,
          drink_dish_id: menu.id,
          user: lunch_admin,
        }
      }, format: :js
      expect(response).to have_http_status(403)
    end
  end
end
