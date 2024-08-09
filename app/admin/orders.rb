ActiveAdmin.register Order do
  permit_params :total_amount, :address, :province, :street, :payment_status, :payment_id, :user_id, :cart_id

  menu false  # This line removes the Orders link from the menu

  controller do
    def calculate_taxes(province, total_amount)
      tax_rates = Province.find_by(name: province)
      gst = total_amount * tax_rates.gst
      pst = total_amount * tax_rates.pst
      hst = total_amount * tax_rates.hst
      { gst: gst, pst: pst, hst: hst }
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :total_amount
    column :payment_status
    column :payment_id
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user
      row :total_amount
      row :payment_status
      row :payment_id
      row :created_at
      row :address
      row :province
      row :street
      row :cart_id
    end

    panel "Products Ordered" do
      table_for(order.line_items) do
        column "Product" do |line_item|
          line_item.product.name
        end
        column "Quantity" do |line_item|
          line_item.quantity
        end
        column "Price" do |line_item|
          number_to_currency(line_item.product.price)
        end
      end
    end

    panel "Taxes" do
      table_for([:taxes]) do
        row "GST" do
          number_to_currency(calculate_taxes(order.user.province, order.total_amount)[:gst])
        end
        row "PST" do
          number_to_currency(calculate_taxes(order.user.province, order.total_amount)[:pst])
        end
        row "HST" do
          number_to_currency(calculate_taxes(order.user.province, order.total_amount)[:hst])
        end
      end
    end

    panel "Grand Total" do
      total_taxes = calculate_taxes(order.user.province, order.total_amount).values.sum
      grand_total = order.total_amount + total_taxes
      number_to_currency(grand_total)
    end
  end
end
