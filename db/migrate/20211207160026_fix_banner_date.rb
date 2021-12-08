class FixBannerDate < ActiveRecord::Migration[6.1]
  def change
    rename_column :banners, :bannerStartDate, :StartDate
    rename_column :banners, :bannerEndDate, :EndDate
  end
end
