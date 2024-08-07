class AddPostalCodeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :postal_code, :string
  end
end
