# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :main_dish, foreign_key: { to_table: :menus }
      t.references :appetizer_dish, foreign_key: { to_table: :menus }
      t.references :drink_dish, foreign_key: { to_table: :menus }
      t.references :user, foreign_key: true
      t.decimal    :total_lunch_cost, default: 0
      t.timestamps
    end
  end
end
