# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it 'is created with valid attributes' do
    expect(user).to be_valid
  end

  it 'requires email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'requires username' do
    user.username = nil
    expect(user).not_to be_valid
  end

  it 'requires currency' do
    user.currency = nil
    expect(user).not_to be_valid
  end
end
