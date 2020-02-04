# frozen_string_literal: true

class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, default: User::USER
  end
end
