class RemoveAddressIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :address_id
  end
end
