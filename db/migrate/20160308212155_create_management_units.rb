class CreateManagementUnits < ActiveRecord::Migration
  def change
    create_table :management_units do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
