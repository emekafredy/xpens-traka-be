# frozen_string_literal: true

class BudgetSerializer < ApplicationSerializer
  attributes :id, :income_est, :expense_est

  attribute :date_from do |budget|
    budget.start_date&.strftime('%m/%d/%Y')
  end

  attribute :date_to do |budget|
    budget.end_date&.strftime('%m/%d/%Y')
  end

  attribute :actual_incomes_total, &:actual_incomes_total
  attribute :actual_expenses_total, &:actual_expenses_total
end
