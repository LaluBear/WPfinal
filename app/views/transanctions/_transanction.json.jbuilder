json.extract! transanction, :id, :user_id, :user_id, :item_id, :price, :amount, :created_at, :updated_at
json.url transanction_url(transanction, format: :json)
