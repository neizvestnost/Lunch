# frozen_string_literal: true

class Api::V1::OrdersController < Api::V1::ApiController
  include Dayable

  def index
    @orders_facade = Orders::IndexFacade.new(day: current_or_default_day)
  end
end
