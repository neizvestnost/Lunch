# frozen_string_literal: true

class MenusController < ApplicationController
  include Dayable

  before_action :check_permissions, only: %i[new create]

  def index
    @menus_facade = Menus::IndexFacade.new(day: params['day'] || current_or_default_day)
  end

  def new
    @menu_item = Menu.new
  end

  def create
    @menu_form = Menus::CreateForm.new(Menu.new, menu_params)

    render_error @menu_form unless @menu_form.save
  end

  private

  def check_permissions
    authorize Menu.new
  end

  def menu_params
    params
      .require(:menu)
      .permit(
        :name,
        :price,
        :course
      )
  end
end
