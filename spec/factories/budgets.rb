# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    start_date { '2023-06-10' }
    end_date { '2023-06-27' }
    user { nil }
    income_est { 99.99 }
    expense_est { 59.99 }
  end
end
