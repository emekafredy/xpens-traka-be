# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :receipt_document

  enum transaction_type: { income: 'Income', expense: 'Expense' }

  validates :date, presence: true
  validates :transaction_type, presence: true
  validates :amount, presence: true, numericality: { other_than: 0 }
end
