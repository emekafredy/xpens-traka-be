# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Budget, type: :model do
  subject(:budget) { create(:budget, user: user) }

  let(:user) { create(:user) }

  it 'is created with valid attributes' do
    expect(budget).to be_valid
  end

  it 'requires start_date' do
    budget.start_date = nil
    expect(budget).not_to be_valid
  end

  it 'requires end_date' do
    budget.end_date = nil
    expect(budget).not_to be_valid
  end

  it 'requires income_est' do
    budget.income_est = nil
    expect(budget).not_to be_valid
  end

  it 'requires expense_est' do
    budget.expense_est = nil
    expect(budget).not_to be_valid
  end

  it 'is invalid if start_date is later than end_dat' do
    budget.start_date = Time.zone.now
    budget.end_date = 1.day.ago
    expect(budget).not_to be_valid
  end
end
