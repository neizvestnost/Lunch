# frozen_string_literal: true

class Menu < ApplicationRecord
  enum course: {
    main: MAIN = 'main',
    appetizer: APPETIZER = 'appetizer',
    drink: DRINK = 'drink'
  }

  has_many :main_dish_orders, class_name: Order.name, foreign_key: 'main_dish_id', dependent: :destroy
  has_many :appetizer_dish_orders, class_name: Order.name, foreign_key: 'appetizer_dish_id', dependent: :destroy
  has_many :drink_dish_orders, class_name: Order.name, foreign_key: 'drink_dish_id', dependent: :destroy
end
