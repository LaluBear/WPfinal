class FixOnsaleToItem < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :Onsale, :onsale
  end
end
