class AddCurrencyToBudgets < ActiveRecord::Migration[7.0]
  def change
    add_column :budgets, :currency, :string, null: false, default: 'NGN'
  end
end
