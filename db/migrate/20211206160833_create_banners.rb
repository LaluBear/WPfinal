class CreateBanners < ActiveRecord::Migration[6.1]
  def change
    create_table :banners do |t|
      t.string :bannerName
      t.date :bannerStartDate
      t.date :bannerEndDate

      t.timestamps
    end
  end
end
