# frozen_string_literal: true

class OrderDecorator < ApplicationDecorator
  DISHES = %w[main_dish appetizer_dish drink_dish].freeze

  delegate :id, :user, :main_dish, :appetizer_dish, :drink_dish
  delegate :email, to: :user, prefix: true

  # def main_dish_name
  # def appetizer_dish_name
  # def drink_dsih_name

  # main_dish&.name
  # appetizer_dish&.name
  # drink_dish&.name
  DISHES.each do |dish|
    define_method("#{dish}_name") do
      public_send(dish)&.name || I18n.t('orders.no_order')
    end
  end
end
