class AddAddressDetailsToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :street, :string unless column_exists?(:customers, :street)
    add_column :customers, :city, :string unless column_exists?(:customers, :city)
    add_column :customers, :postal_code, :string unless column_exists?(:customers, :postal_code)
  end
end
