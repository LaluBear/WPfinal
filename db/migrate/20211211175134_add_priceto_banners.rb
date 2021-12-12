class AddPricetoBanners < ActiveRecord::Migration[6.1]
  def change
    add_column :banners, :price, :integer
  end
end
