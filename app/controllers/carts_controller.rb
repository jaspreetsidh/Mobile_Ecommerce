class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :destroy]

  def show
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Your cart is currently empty.'
  end
end
