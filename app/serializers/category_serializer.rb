# frozen_string_literal: true

class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :user_id, :section
end
