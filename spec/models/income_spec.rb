require 'rails_helper'

RSpec.describe Income, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  subject(:income) { create(:income, user: user, category: category) }

  it 'is created with valid attributes' do
    expect(income).to be_valid
  end

  it 'requires amount' do
    income.amount = nil
    expect(income).not_to be_valid
  end

  it 'requires  date' do
    income.date = nil
    expect(income).not_to be_valid
  end

  it 'requires category' do
    income.category = nil
    expect(income).not_to be_valid
  end

  it 'requires user' do
    income.user = nil
    expect(income).not_to be_valid
  end

  it 'sets currency by default if non is provided' do
    income.currency = nil
    expect(income).to be_valid
  end
end
