# frozen_string_literal: true

class TransactionSerializer < ApplicationSerializer
  attributes :id, :amount, :currency, :transaction_type, :transaction_id

  attribute :date do |transaction|
    transaction.date&.strftime('%d %b, %Y')
  end

  attribute :category_name do |transaction|
    transaction.category.name
  end
end
