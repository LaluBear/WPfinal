class FixBanner < ActiveRecord::Migration[6.1]
  def change
    rename_column :banners, :bannerName, :name

  end
end
