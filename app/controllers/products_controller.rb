
class ProductsController < ApplicationController
  def index
    @categories = Category.all  

    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end

    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(10)  
  end

  def show
    @product = Product.find(params[:id])
  end


end
