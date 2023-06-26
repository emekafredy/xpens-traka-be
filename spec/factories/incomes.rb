FactoryBot.define do
  factory :income do
    amount { 1000.00 }
    date { '16/02/2023' }
    user_id { nil }
    category_id { nil }
    currency { 'NGN' }
  end
end
