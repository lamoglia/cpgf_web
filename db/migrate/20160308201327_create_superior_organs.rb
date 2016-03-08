class CreateSuperiorOrgans < ActiveRecord::Migration
  def change
    create_table :superior_organs do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
