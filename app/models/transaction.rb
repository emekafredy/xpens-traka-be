# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :receipt_document

  enum transaction_type: { income: 'Income', expense: 'Expense' }

  validates :date, presence: true
  validates :transaction_type, presence: true
  validates :amount, presence: true, numericality: { other_than: 0 }

  before_create :generate_transaction_id

  def generate_transaction_id
    random_char = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join
    self.transaction_id = "XT_#{random_char}"
  end
end
