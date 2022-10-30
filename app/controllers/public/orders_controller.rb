class Public::OrdersController < Public::Base
  def new
    @order = Order.new
    @order.customer_id = current_customer.id
  end

  def index
  end

  def show
  end
end
