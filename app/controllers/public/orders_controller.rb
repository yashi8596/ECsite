class Public::OrdersController < Public::Base
  def new
    @order = current_customer.orders.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @order.shipping_fee = 800
    @order.total_payment = @total + @order.shipping_fee
    @order = current_customer.orders.new(order_params)

    if @order.invalid?
      render :new
    end
  end

  def success
  end

  def create
    if @order.create!(order_params)
      redirect_to success_order_path
    else
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders.all
    @order_details = current_customer.order_details.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_detail = current_customer.order_details.all
    @order.shipping_fee = 800
    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :order_status)
  end
end
