class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(params[:id])
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def confirm

  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    @customer.is_deleted = true
    redirect_to '/'
  end
end
