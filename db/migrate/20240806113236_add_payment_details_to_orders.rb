class AddPaymentDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_status, :string
    add_column :orders, :payment_id, :string
  end
end
