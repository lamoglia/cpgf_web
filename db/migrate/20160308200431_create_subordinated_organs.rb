class CreateSubordinatedOrgans < ActiveRecord::Migration
  def change
    create_table :subordinated_organs do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
