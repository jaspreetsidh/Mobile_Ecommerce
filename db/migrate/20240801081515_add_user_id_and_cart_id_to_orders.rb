class AddUserIdAndCartIdToOrders < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:orders, :user_id)
      add_column :orders, :user_id, :integer
      add_index :orders, :user_id
    end
    
    unless column_exists?(:orders, :cart_id)
      add_column :orders, :cart_id, :integer
      add_index :orders, :cart_id
    end
  end
end
