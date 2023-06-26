# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :email, :username

  attribute :created_date do |user|
    user.created_at&.strftime('%m/%d/%Y')
  end
end
