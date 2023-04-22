class Public::AddressesController < Public::Base

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = current_customer.addresses.new(address_params)

    if @address.save
      flash.notice = "配送先住所を登録しました。"
      redirect_to addresses_path
    else
      flash.now[:alert] = "入力項目に誤りがあります。操作をやり直してください。"
      @address = Address.new
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])

    if @address.update(address_params)
      flash.notice = "登録内容を変更しました。"
      redirect_to addresses_path
    else
      flash.now[:alert] = "入力項目に誤りがあります。操作をやり直してください。"
      render :edit
    end
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    flash.notice = "配送先住所を削除しました。"
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
