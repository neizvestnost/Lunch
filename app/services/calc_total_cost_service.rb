# frozen_string_literal: true

class CalcTotalCostService < ApplicationService
  initialize_with :order

  def call
    order.update(total_lunch_cost: total_cost)
  end

  private

  def total_cost
    sql = "SELECT SUM(price) FROM menus
                             INNER JOIN orders
                             ON menus.id
                             IN (orders.main_dish_id, orders.appetizer_dish_id, orders.drink_dish_id)
                             WHERE orders.id = #{order.id}"
    Menu.find_by_sql(sql)[0].sum
  end
end
