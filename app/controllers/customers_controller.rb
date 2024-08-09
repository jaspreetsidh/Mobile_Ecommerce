class CustomersController < ApplicationController
  before_action :authenticate_user!

  def new
    @customer = Customer.new
  end

  def create
    @customer = current_user.build_customer(customer_params)
    if @customer.save
      redirect_to some_path, notice: 'Customer profile was successfully created.'
    else
      render :new
    end
  end

  def edit
    @customer = current_user.customer
  end

  def update
    @customer = current_user.customer
    if @customer.update(customer_params)
      redirect_to another_path, notice: 'Customer profile was successfully updated.'
    else
      render :edit
    end
  end

  private


  end
end
