class ChangeDefaultQuantityInOrderItems < ActiveRecord::Migration[7.0]
  def change
    change_column :order_items, :quantity, :integer, default: 1
  end
end
