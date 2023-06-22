class Category < ApplicationRecord
  belongs_to :user, optional: true

  enum section: { income: "Income", expense: "Expense" }

  validates :name, presence: true
end
