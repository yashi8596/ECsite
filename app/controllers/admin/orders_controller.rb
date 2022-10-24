class Admin::OrdersController < Admin::Base
  def show
    @order = Order.find(params[:id])
    @order_details = @order.Order_detail.all
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(@order.id)
      redirect_to admin_order_path(@order.id)

    else
      render :show

    end
  end
end
