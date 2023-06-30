# frozen_string_literal: true

class TransactionSerializer < ApplicationSerializer
  attributes :id, :amount, :currency, :transaction_type

  attribute :date do |transaction|
    transaction.date&.strftime('%m/%d/%Y')
  end

  attribute :category_name do |transaction|
    transaction.category.name
  end
end
