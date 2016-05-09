class AddFriendlyDescriptionToTransactionType < ActiveRecord::Migration
  def change
    add_column :transaction_types, :friendly_description, :string
  end
end
