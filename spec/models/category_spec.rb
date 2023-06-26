# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { create(:category, user: user) }

  let(:user) { create(:user) }

  it 'is created with valid attributes' do
    expect(category).to be_valid
  end

  it 'requires name' do
    category.name = nil
    expect(category).not_to be_valid
  end

  it 'requires section' do
    category.section = nil
    expect(category).not_to be_valid
  end

  it 'does not requires user' do
    category.user = nil
    expect(category).to be_valid
  end
end
