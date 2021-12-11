class FixNameFromItem < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :itemname, :name
  end
end
