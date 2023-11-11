class RemoveQuantityTotalPriceProductIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :quantity, :integer
    remove_column :orders, :total_price, :decimal
    remove_column :orders, :product_id, :bigint
  end
end
