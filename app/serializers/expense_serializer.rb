# frozen_string_literal: true

class ExpenseSerializer < ApplicationSerializer
  attributes :id, :amount

  attribute :date do |expense|
    expense.date&.strftime('%m/%d/%Y')
  end

  attribute :category_name do |expense|
    expense.category.name
  end
end
