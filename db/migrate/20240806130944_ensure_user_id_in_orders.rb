class EnsureUserIdInOrders < ActiveRecord::Migration[7.1]
  def change
    # Remove customer_id if it still exists
    if column_exists?(:orders, :customer_id)
      remove_column :orders, :customer_id
    end

    # Ensure user_id column is present and not nullable
    if column_exists?(:orders, :user_id)
      change_column_null :orders, :user_id, false
    end
  end
end
