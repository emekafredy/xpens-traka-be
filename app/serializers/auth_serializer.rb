# frozen_string_literal: true

class AuthSerializer < ApplicationSerializer
  attributes :id, :email, :username, :avatar

  attribute :created_date do |user|
    user.created_at&.strftime('%m/%d/%Y')
  end

  attribute :auth_token do |user|
    "Bearer #{user.auth_token}"
  end

  attribute :incomes_total, &:incomes_total
  attribute :expenses_total, &:expenses_total

  attribute :recent_transactions do |user|
    user.recent_transactions.map do |tr|
      {
        transactionId: tr.transaction_id,
        amount: tr.amount,
        transactionType: tr.transaction_type,
        date: tr.date&.strftime('%d %b, %Y'),
        category: tr.category.name
      }
    end
  end
  attribute :monthly_grouped do |user|
    {
      incomes: user.monthly_grouped_incomes,
      expenses: user.monthly_grouped_expenses
    }
  end
end
