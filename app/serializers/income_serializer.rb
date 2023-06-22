class IncomeSerializer < ApplicationSerializer
  attributes :id, :amount

  attribute :date do |income|
    income.date && income.date.strftime('%m/%d/%Y')
  end

  attribute :category_name do |income|
    income.category.name
  end
end
