class Public::HomesController < Public::Base
  def top
    @genres = Genre.all
    @items = Item.order('id DESC').limit(4)
  end

  def about
  end
end
