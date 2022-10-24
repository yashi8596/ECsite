class Admin::ItemsController < Admin::Base
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
end
