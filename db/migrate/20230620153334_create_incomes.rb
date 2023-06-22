class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes, id: :uuid do |t|
      t.date :date, null: false
      t.decimal :amount, precision: 16, scale: 2
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
