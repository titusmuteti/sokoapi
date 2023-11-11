class AddAddressIdPaymentStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :address, null: false, foreign_key: true
    add_column :orders, :payment_status, :string
  end
end
