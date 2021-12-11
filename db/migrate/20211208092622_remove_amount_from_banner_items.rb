class RemoveAmountFromBannerItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :banner_items, :amount
  end
end
