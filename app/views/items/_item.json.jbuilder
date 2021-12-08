json.extract! item, :id, :itemname, :rarity, :item_img_url, :created_at, :updated_at
json.url item_url(item, format: :json)
