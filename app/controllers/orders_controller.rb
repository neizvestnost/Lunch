# frozen_string_literal: true

class OrdersController < ApplicationController
  include Dayable

  before_action :pemissions, only: %i[index create]

  def index
    @orders_facade = Orders::IndexFacade.new(day: params['day'] || current_or_default_day, page: params[:page], request: request)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @order_form = Orders::CreateForm.new(current_user.orders.new, order_params)

    render_error @order_form unless @order_form.save
  end

  private

  def pemissions
    authorize Order.new
  end

  def order_params
    params
      .require(:order)
      .permit(
        :appetizer_dish_id,
        :drink_dish_id,
        :main_dish_id,
        :blank
      )
  end
end
