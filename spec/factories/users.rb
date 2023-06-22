FactoryBot.define do
  factory :user do
    email { 'john.doe@gmail.com' }
    password { 'pass123' }
    username { 'john.doe' }
    currency { 'NGN' }
  end
end
