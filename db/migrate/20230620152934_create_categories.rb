# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.string :section
      t.references :user, type: :uuid, null: true, foreign_key: true

      t.timestamps
    end
  end
end
