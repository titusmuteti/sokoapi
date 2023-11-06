json.extract! order, :id, :quantity, :total_price, :order_status, :order_date, :address_id, :user_id, :product_id, :created_at, :updated_at
json.url order_url(order, format: :json)
