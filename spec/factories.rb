# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email     { Faker::Internet.email }
    name      { Faker::Name.name }
    password  { '123456' }
    role { 'user' }
  end

  factory :lunch_admin, parent: :user do
    role { 'lunch_admin' }
  end

  factory :menu do
    name    { Faker::Food.dish }
    price   { Faker::Commerce.price }
    course  { 'main' }
  end
end
