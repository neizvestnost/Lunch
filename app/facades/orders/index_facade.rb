# frozen_string_literal: true

class Orders::IndexFacade
  include Pagy::Backend

  def initialize(day:, page:, request:)
    @day = day
    @page = page
    @request = request
  end

  def total_lunch_cost_for_today
    orders_for_day.sum(:total_lunch_cost)
  end

  def decorated_and_paginated_orders_for_day
    decorate_orders(paginated_orders_for_day)
  end

  def decorated_orders_for_day
    decorate_orders(orders_for_day)
  end

  def orders_metadata
    @data[:orders_metadata]
  end

  def pagy_instance
    @data[:pagy]
  end

  private

  attr_reader :page, :request

  def orders_for_day
    @orders_for_day ||= Order
                        .includes(
                          :main_dish,
                          :appetizer_dish,
                          :drink_dish,
                          :user
                        )
                        .where(
                          "orders.created_at >= '#{day_parse.beginning_of_day}'
                          AND orders.created_at <= '#{day_parse.end_of_day}'"
                        )
  end

  def paginated_orders_for_day
    @data ||= Pagination::Pagy::PaginationService.call(
      orders: orders_for_day,
      page: page,
      request: request
    )

    @data[:paginated_orders]
  end

  def decorate_orders(orders)
    ::OrderDecorator.decorate_collection(orders)
  end

  def day_parse
    @parsed_day ||= @day.is_a?(String) ? Time.parse(@day) : @day
  end
end
