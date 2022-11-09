class Public::OrdersController < Public::Base
  def new
    @order = Order.new
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @order.shipping_fee = 800
    @order.total_payment = @total.round.to_i + @order.shipping_fee
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

    @order = current_customer.orders.new(order_params)

    if params[:order][:address_number] == "1"

      @order.name = current_customer.full_name(current_customer.last_name, current_customer.first_name)
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code

    elsif params[:order][:address_number] == "2"

      if Address.exists?(name: params[:order][:registered])

        @order.name = Address.find(params[:order][:registered]).name
        @order.address = Address.find(params[:order][:registered]).address
      else
        render :new
      end

    elsif params[:order][:address_number] == "3"

      new_address = current_customer.addresses.new(address_params)

      @order.name = new_address.name
      @order.address = new_address.address
      @order.postal_code = new_address.postal_code

    end
  end

  def success
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save

      cart_items = current_customer.cart_items.all
      order_detail = OrderDetail.new

      cart_items.each do |cart|
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.price = cart.item.price
        order_detail.amount = cart.amount

        order_detail.save
      end

      redirect_to success_order_path
      cart_items.destroy_all
    else

      @order = Order.new
      @cart_items = current_customer.cart_items.all
      @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
      @order.shipping_fee = 800
      @order.total_payment = @total.round.to_i + @order.shipping_fee
      render :new
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
    params.require(:order).permit(:payment_method, :name, :address, :postal_code, :customer_id, :shipping_fee, :total_payment)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end
end
