# frozen_string_literal: true

class Budget < ApplicationRecord
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :income_est, presence: true, numericality: { greater_than: 0 }
  validates :expense_est, presence: true, numericality: { greater_than: 0 }

  validates :start_date, :end_date,
            overlap: {
              scope: 'user_id',
              message_content: 'or End date of this budget overlaps with another created budget.'
            }

  validate :date_config

  def date_deficit?
    return if end_date.nil? || start_date.nil?

    end_date < start_date
  end

  def date_config
    errors.add(:start_date, 'must be lesser the End date') if date_deficit?
  end
end
