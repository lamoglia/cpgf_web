class CreateTransactionTypes < ActiveRecord::Migration
  def change
    create_table :transaction_types do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
