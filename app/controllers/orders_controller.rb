class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show_invoice, :success]

  def new
    @order = Order.new
    @order.street = current_user.street
    @order.province = current_user.province
  end

  def create
    @order = Order.new(order_params.merge(user: current_user, cart: current_cart))

    if @order.save
      if process_payment
        current_cart.line_items.destroy_all
        redirect_to success_order_path(@order), notice: 'Order successfully placed.'
      else
        @order.destroy
        flash.now[:alert] = 'Payment failed. Please try again.'
        render :new
      end
    else
      render :new
    end
  end

  def show_invoice
    @user = @order.user
    @taxes = calculate_taxes(@user.province, @order.total_amount)
  end

  def index
    @orders = current_user.orders
    @orders_with_taxes = @orders.map do |order|
      {
        order: order,
        taxes: calculate_taxes(order.user.province, order.total_amount)
      }
    end
  end

  def success
    @order = Order.find(params[:id])
  end

  private

  def set_cart
    @cart = current_cart
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def calculate_taxes(province, total_amount)
    tax_rates = Province.find_by(name: province)
    gst = total_amount * (tax_rates&.gst || 0)
    pst = total_amount * (tax_rates&.pst || 0)
    hst = total_amount * (tax_rates&.hst || 0)
    { gst: gst, pst: pst, hst: hst }
  end

  def order_params
    params.require(:order).permit(:total_amount, :address, :province, :street, :payment_status, :payment_id)
  end

  def process_payment
    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        amount: (@order.total_amount * 100).to_i, # amount in cents
        currency: 'usd',
        source: token,
        description: "Order for #{@order.user.email}"
      )
      @order.update(payment_status: 'paid', payment_id: charge.id)
      return true
    rescue Stripe::CardError => e
      Rails.logger.error "Stripe error: #{e.message}"
      return false
    rescue StandardError => e
      Rails.logger.error "General error: #{e.message}"
      return false
    end
  end
end
