class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :value
      t.date :date, index: true
      t.references :superior_organ, index: true, foreign_key: true
      t.references :subordinated_organ, index: true, foreign_key: true
      t.references :management_unit, index: true, foreign_key: true
      t.references :source, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.references :favored, index: true, foreign_key: true
      t.references :transaction_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
