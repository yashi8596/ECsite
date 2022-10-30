class Public::CartItemsController < Public::Base
  
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @cart_item = Cart_item.find(params[:id])
    @cart_item.customer_id = current_customer.id
    
    if @cart_item.save
      flash.notice = "カート内商品の情報を更新しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    cart_item = Cart_item.find(params[:id])
    cart_item.customer_id = current_customer.id
    
    cart_item.destroy
    flash.notice = "該当商品を削除しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_customer.cart_items.all
    cart_items.destroy
    flash.notice = "カート内の全商品を削除しました。"
    redirect_to cart_items_path
  end

  def create
    @cart_item = Cart_item.new
    @cart_item.customer_id = current_customer.id
    
    if @cart_item.save
      flash.notice = "カートに商品を追加しました。"
      redirect_to cart_items_path
    else
      render "items/show"
    end
  end

end
