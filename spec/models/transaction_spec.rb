# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject(:transaction) { create(:transaction, user: user, category: category) }

  let(:user) { create(:user) }
  let(:category) { create(:category) }

  it 'is created with valid attributes' do
    expect(transaction).to be_valid
  end

  it 'requires amount' do
    transaction.amount = nil
    expect(transaction).not_to be_valid
  end

  it 'requires date' do
    transaction.date = nil
    expect(transaction).not_to be_valid
  end

  it 'requires category' do
    transaction.category = nil
    expect(transaction).not_to be_valid
  end

  it 'requires user' do
    transaction.user = nil
    expect(transaction).not_to be_valid
  end

  it 'requires transaction_type' do
    transaction.transaction_type = nil
    expect(transaction).not_to be_valid
  end

  it 'sets currency by default if non is provided' do
    transaction.currency = nil
    expect(transaction).to be_valid
  end
end
