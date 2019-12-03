# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "email#{n}@sample.com" }
    password { "test" }
    password_confirmation { "test" }
  end
end
