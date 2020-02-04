# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :main_dish, class_name: Menu.name, optional: true
  belongs_to :appetizer_dish, class_name: Menu.name, optional: true
  belongs_to :drink_dish, class_name: Menu.name, optional: true
end
