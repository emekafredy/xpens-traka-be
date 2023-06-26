# frozen_string_literal: true

class IncomeSerializer < ApplicationSerializer
  attributes :id, :amount

  attribute :date do |income|
    income.date&.strftime('%m/%d/%Y')
  end

  attribute :category_name do |income|
    income.category.name
  end
end
