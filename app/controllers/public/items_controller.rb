class Public::ItemsController < Public::Base
  def index
    @items = Item.page(params[:page]).per(8)
    @items_amount = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
