class FixBannerDate2 < ActiveRecord::Migration[6.1]
  def change
    rename_column :banners, :StartDate, :startDate
    rename_column :banners, :EndDate, :endDate
  end
end
