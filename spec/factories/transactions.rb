# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { 1000.00 }
    date { '16/02/2023' }
    user_id { nil }
    category_id { nil }
    currency { 'NGN' }
    transaction_type { 'Income' }
  end
end
