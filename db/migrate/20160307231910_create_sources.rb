class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :file_name
      t.date :reference
      t.datetime :imported_at

      t.timestamps null: false
    end
  end
end
