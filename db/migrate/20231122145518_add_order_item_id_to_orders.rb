class AddOrderItemIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_item_id, :integer, array: true, default: []
  end
end
