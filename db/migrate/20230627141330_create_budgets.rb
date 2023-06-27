class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets, id: :uuid do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.decimal :income_est, precision: 16, scale: 2
      t.decimal :expense_est, precision: 16, scale: 2

      t.timestamps
    end
  end
end
