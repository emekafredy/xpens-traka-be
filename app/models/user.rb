# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  #  :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :nullify
  has_many :budgets, dependent: :destroy
  has_many :transactions, dependent: :destroy

  has_one_attached :avatar

  validates :email, presence: true
  validates :username, presence: true
  validates :currency, presence: true

  def generate_token
    JWT.encode(
      { id: id, exp: 5.days.from_now.to_i, email: email },
      ENV['TOKEN_SECRET_KEY']
    )
  end

  def auth_token
    generate_token
  end

  def recent_transactions
    transactions.order(created_at: :desc).limit(10)
  end

  def incomes_total
    beginning_of_month = Time.zone.today.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    transactions.where(
      transaction_type: 'Income',
      created_at: beginning_of_month..end_of_month
    ).sum(:amount)
  end

  def expenses_total
    beginning_of_month = Time.zone.today.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    transactions.where(
      transaction_type: 'Expense',
      created_at: beginning_of_month..end_of_month
    ).sum(:amount)
  end

  def monthly_grouped_transactions_by_type(t_type)
    ordered = transactions.where(transaction_type: t_type).order(date: :desc)
    grouped_data = ordered.group_by { |tr| tr.date.strftime('%b, %y') }

    grouped_data.each_with_object([]) do |(key, value), array|
      array << ({ key => value.sum { |t| t[:amount] } })
    end
  end

  def monthly_grouped_incomes
    monthly_grouped_transactions_by_type('Income').take(8)
  end

  def monthly_grouped_expenses
    monthly_grouped_transactions_by_type('Expense').take(8)
  end
end
