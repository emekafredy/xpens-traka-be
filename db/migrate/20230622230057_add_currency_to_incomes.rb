class AddCurrencyToIncomes < ActiveRecord::Migration[7.0]
  def change
    add_column :incomes, :currency, :string, null: false, default: 'NGN'
  end
end
