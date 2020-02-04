# frozen_string_literal: true

json.orders do
  json.array! @orders_facade.orders_for_day do |order|
    json.id                      order.id
    json.main_dish_name          order.main_dish_name
    json.appetizer_dish_name     order.appetizer_dish_name
    json.drink_dish_name         order.drink_dish_name
    json.total_lunch_cost order.total_lunch_cost
    json.customer do
      json.customer_name           order.user_name
      json.customer_email          order.user_email
    end
  end
end
