# frozen_string_literal: true

class Income < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :receipt_document

  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
