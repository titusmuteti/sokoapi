class ChangeOrderItemIdToOrderItemIds < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :order_item_id, :integer, array: true, default: [], null: false
    rename_column :orders, :order_item_id, :order_item_ids
  end
end
