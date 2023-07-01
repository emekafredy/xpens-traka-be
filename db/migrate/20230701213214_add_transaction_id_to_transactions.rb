class AddTransactionIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transaction_id, :string, null: false
  end
end
