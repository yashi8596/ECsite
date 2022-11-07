class Public::CustomersController < Public::Base
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(current_customer_params)
      flash.notice = "アカウント情報を更新しました。"
      redirect_to customers_path
    else
      render :edit
    end
  end

  def confirm
    @customer = current_customer
  end

  def unsubscribe
    @customer = current_customer
    @customer.update(is_deleted: "true")

    reset_session

    redirect_to '/'
  end

  private

  def current_customer_params
    params.require(:customer).permit(:last_name, :first_name,
      :last_name_kana, :first_name_kana, :postal_code,
      :address, :telephone_number, :email)
  end
end
