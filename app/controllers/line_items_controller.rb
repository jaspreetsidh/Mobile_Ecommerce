class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    if @line_item.save
      redirect_to @line_item.cart, notice: 'Product was successfully added to cart.'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    if @line_item.update(line_item_params)
        redirect_to cart_path(@line_item.cart), notice: 'Quantity updated successfully.'
    else
        redirect_to cart_path(@line_item.cart), alert: 'Unable to update quantity.'
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(@line_item.cart), notice: 'Line item was successfully removed.'
  end

  def decrement
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.decrement!(:quantity)
    else
      @line_item.destroy
    end
    redirect_to cart_path(@line_item.cart), notice: 'Line item quantity was successfully updated.'
  end
  
  private

  def line_item_params
  params.require(:line_item).permit(:quantity)
  end

end
