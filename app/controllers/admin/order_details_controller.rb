class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    order_details = @order.order_details

    if @order_detail.update(detail_params)
      if @order_detail.work_status == "製作中"

        @order.order_status = "製作中"

      elsif @order_detail.work_status == "製作完了"

        if order_details.count == 1
          @order.order_status = "発送準備中"

        else
          order_details.each do |detail|
            if detail.work_status == "製作中"

              flash.notice ="ステータスを更新しました。"
              redirect_to admin_order_path(@order_detail.order.id) and return
            end
          end

          @order.order_status = "発送準備中"
        end

      end

      @order.save

      flash.notice ="ステータスを更新しました。"
      redirect_to admin_order_path(@order_detail.order.id) and return
    else
      flash.alert ="お手数ですが、操作をやり直してください。"
      render :back and return
    end
  end

  private

  def detail_params
    params.require(:order_detail).permit(:work_status)
  end

  def order_params
    params.require(:order).permit(:order_status)
  end
end
