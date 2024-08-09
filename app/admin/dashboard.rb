# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Orders" do
          table_for Order.order(created_at: :desc).limit(5) do
            column("Order ID") { |order| link_to order.id, admin_order_path(order) }
            column("Total Amount") { |order| number_to_currency(order.total_amount) }
            column("Ordered By") { |order| order.user.email }
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to the Admin Dashboard."
        end
      end
    end
  end # content
end
