# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    date { '2023-06-27' }
    amount { -59.99 }
    user { nil }
    currency { 'NGN' }
    category { nil }
  end
end
