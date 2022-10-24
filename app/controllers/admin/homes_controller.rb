class Admin::HomesController < Admin::Base
  def top
    @orders = Order.all
  end
end
