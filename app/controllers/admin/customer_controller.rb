class Admin::CustomerController < ApplicationController
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end
end
