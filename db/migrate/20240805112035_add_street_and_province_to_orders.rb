class AddStreetAndProvinceToOrders < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:orders, :street)
      add_column :orders, :street, :string
    end

    unless column_exists?(:orders, :province)
      add_column :orders, :province, :string
    end
  end
end
