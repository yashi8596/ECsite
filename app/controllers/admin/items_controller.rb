class Admin::ItemsController < Admin::Base
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash.notice = "商品を登録しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "入力項目に誤りがあります。操作をやり直してください。"
      render :new
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash.notice = "商品情報を更新しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "入力項目に誤りがあります。操作をやり直してください。"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :item_image, :is_active, :created_at)
  end
end
