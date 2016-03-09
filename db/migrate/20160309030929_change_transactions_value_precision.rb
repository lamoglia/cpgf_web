class ChangeTransactionsValuePrecision < ActiveRecord::Migration
  def change
    change_column :transactions, :value, :decimal, :precision => 10, :scale => 2, :null => false
  end
end
