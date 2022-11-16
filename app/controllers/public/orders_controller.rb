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

  def create
    @order = current_customer.orders.new(order_params)

    cart_items = current_customer.cart_items.all

    ordered_item = []
    @ordered_items = cart_items

      @ordered_items.each do |i|
        ordered_item << @order.order_details.build(item_id: i.item_id, price: i.item.price, amount: i.amount, work_status: 0)
      end

    OrderDetail.import ordered_item

    if @order.save

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

  def success
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :name, :address, :postal_code, :customer_id, :shipping_fee, :total_payment, :order_status)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end
end
