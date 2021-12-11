class AddOnsaleToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :Onsale, :string
  end
end
