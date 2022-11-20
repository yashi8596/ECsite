class Admin::OrdersController < Admin::Base
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details

    if @order.update(order_params)

      if @order.order_status == "入金確認"
        @order_details.each do |detail|
          detail.work_status = "製作待ち"
          detail.save
        end
      end

      flash.notice ="ステータスを更新しました。"
      redirect_to admin_order_path(@order.id)

    else
      flash.alert ="お手数ですが、操作をやり直してください。"
      render :back

    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
