class CreateFavored < ActiveRecord::Migration
  def change
    create_table :favored do |t|
      t.string :name
      t.string :masked_document
      t.string :url
      t.decimal :total_transactions, :precision => 12, :scale => 2
      t.string :meta_title
      t.string :meta_description
      t.string :meta_image

      t.timestamps null: false
    end
  end
end
