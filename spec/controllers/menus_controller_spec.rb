# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  let(:lunch_admin) { create(:lunch_admin) }
  let(:user)        { create(:user) }
  let(:menu)        { create(:menu) }
  let(:build_menu)  { build(:menu) }

  describe 'GET index' do
    it 'have status 200 if user authorize' do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'have status 200 if lunch_admin authorize' do
      sign_in lunch_admin
      get :index
      expect(response).to have_http_status(200)
    end

    it 'have status 200 if user authorize and day passed' do
      sign_in user
      get :index, params: { day: 'monday' }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'have status 302 if unauthorize' do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET new' do
    it 'assign item if lunch_admin authorize' do
      sign_in lunch_admin
      get :new
      expect(assigns(:menu_item)).to be_a_new(Menu)
    end

    it 'dont`t assign item if user authorize' do
      sign_in user
      get :new
      expect(response).to have_http_status(403)
    end

    it 'dont`t assign item if user unauthorize' do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST create' do
    it 'create item if admin authorize' do
      sign_in lunch_admin
      post :create, params: {
        menu: {
          name: menu.name,
          price: menu.price,
          course: menu.course
        }
      }, format: :js
      expect(Menu.first.name).to eq(menu.name)
    end

    it 'don`t create item if user authorize' do
      sign_in user
      post :create, params: {
        menu: {
          name: menu.name,
          price: menu.price,
          course: menu.course
        }
      }, format: :js
      expect(response).to have_http_status(403)
    end

    it 'don`t create item if unauthorize' do
      post :create, params: {
        menu: {
          name: menu.name,
          price: menu.price,
          course: menu.course
        }
      }
      expect(response).to have_http_status(302)
    end

    it 'don`t create item if something is nil' do
      sign_in user
      post :create, params: {
        menu: {
          day: nil,
          name: nil,
          price: build_menu.price,
          course: nil
        }
      }
      expect(Menu.all).to eq([])
    end

    it 'don`t create item if day on weekend' do
      sign_in user
      post :create, params: {
        menu: {
          day: 'sunday',
          name: build_menu.name,
          price: build_menu.price,
          course: build_menu.course
        }
      }
      expect(Menu.all).to eq([])
    end
  end
end
