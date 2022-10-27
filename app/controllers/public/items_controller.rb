class Public::ItemsController < Public::Base
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
