class Public::CartItemsController < Public::Base

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash.notice = "カート内商品の情報を更新しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])

    cart_item.destroy
    flash.notice = "該当商品を削除しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_customer.cart_items.all
    cart_items.destroy_all
    flash.notice = "カート内の全商品を削除しました。"
    redirect_to cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)

    if @cart_item.item_id === item.item_id

      @cart_item.amount = @cart_item.amount.to_i + item.amount
      @cart_item.update(cart_item_params)

      flash.notice = "カート内商品の情報を更新しました。"
      redirect_to cart_items_path
    else
      if @cart_item.save
        flash.notice = "カートに商品を追加しました。"
        redirect_to cart_items_path
      else
        flash.notice = "お手数ですが、操作をやり直して下さい。"
        redirect_to item_path(@cart_item.item_id)
      end
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
