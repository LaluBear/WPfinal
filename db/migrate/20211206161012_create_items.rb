class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :itemname
      t.string :rarity
      t.string :item_img_url

      t.timestamps
    end
  end
end
