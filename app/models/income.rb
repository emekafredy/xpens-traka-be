class Income < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :receipt_document

  validates :date, presence: true
  validates :amount, presence: true
end
