# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  subject(:expense) { create(:expense, user: user, category: category) }

  let(:user) { create(:user) }
  let(:category) { create(:category) }

  it 'is created with valid attributes' do
    expect(expense).to be_valid
  end

  it 'requires amount' do
    expense.amount = nil
    expect(expense).not_to be_valid
  end

  it 'requires date' do
    expense.date = nil
    expect(expense).not_to be_valid
  end

  it 'requires category' do
    expense.category = nil
    expect(expense).not_to be_valid
  end

  it 'requires user' do
    expense.user = nil
    expect(expense).not_to be_valid
  end

  it 'sets currency by default if non is provided' do
    expense.currency = nil
    expect(expense).to be_valid
  end

  it 'amount must be negative' do
    expense.amount = 100.0
    expect(expense).not_to be_valid
  end
end
