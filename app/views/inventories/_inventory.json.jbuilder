json.extract! inventory, :id, :user_id, :item_id, :amount, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
