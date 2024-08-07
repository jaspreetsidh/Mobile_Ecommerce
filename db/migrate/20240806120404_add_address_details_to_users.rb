class AddAddressDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists? :users, :street
      add_column :users, :street, :string
    end
    unless column_exists? :users, :province
      add_column :users, :province, :string
    end
    unless column_exists? :users, :city
      add_column :users, :city, :string
    end
    unless column_exists? :users, :postal_code
      add_column :users, :postal_code, :string
    end
  end
end
