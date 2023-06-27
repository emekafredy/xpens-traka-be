# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :receipt_document

  validates :date, presence: true
  validates :amount, presence: true, numericality: { less_than: 0 }

  # before_validation :convert_amount_to_negative

  # def convert_amount_to_negative
  #   self.amount = -(self.amount)
  # end
end
