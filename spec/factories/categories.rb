FactoryBot.define do
  factory :category do
    name { Faker::Book.title }
    section { 'Income' }
    user_id { nil }
  end
end
