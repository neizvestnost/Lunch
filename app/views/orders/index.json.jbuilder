# frozen_string_literal: true

json.orders do
  json.array! @orders_facade.decorated_and_paginated_orders_for_day do |order|
    json.id                      order.id
    json.main_dish_name          order.main_dish_name
    json.appetizer_dish_name     order.appetizer_dish_name
    json.drink_dish_name         order.drink_dish_name
    json.customer do
      json.customer_email order.user_email
    end
  end
end

json.pagy do
  json.prev               @orders_facade.orders_metadata[:prev]
  json.prev_url           @orders_facade.orders_metadata[:prev_url]
  json.next               @orders_facade.orders_metadata[:next]
  json.next_url           @orders_facade.orders_metadata[:next_url]
  json.scaffold_url       @orders_facade.orders_metadata[:scaffold_url]
  json.series do
    json.array! @orders_facade.orders_metadata[:series]
  end
end
