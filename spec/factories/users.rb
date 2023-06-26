FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'pass123' }
    username { 'john.doe' }
    currency { 'NGN' }
  end
end
