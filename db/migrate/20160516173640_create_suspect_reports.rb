class CreateSuspectReports < ActiveRecord::Migration
  def change
    create_table :suspect_reports do |t|
      t.string :name
      t.string :email
      t.text :description
      t.integer :transaction_id

      t.timestamps
    end

    add_index :suspect_reports, :transaction_id
  end
end
