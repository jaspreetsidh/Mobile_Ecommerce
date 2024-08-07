class RenameCustomerIdToUserIdInOrders < ActiveRecord::Migration[7.1]
  def change
    # Only rename if 'customer_id' exists and is to be replaced by 'user_id'
    if column_exists?(:orders, :customer_id) && !column_exists?(:orders, :user_id)
      rename_column :orders, :customer_id, :user_id
    end
    
    # Ensure the column 'user_id' exists and is not nullable
    if column_exists?(:orders, :user_id)
      change_column_null :orders, :user_id, false
    end
  end
end
