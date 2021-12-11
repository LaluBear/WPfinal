class AddpricetoInventory < ActiveRecord::Migration[6.1]
  def change
    add_column :inventories, :price, :integer
  end
end
