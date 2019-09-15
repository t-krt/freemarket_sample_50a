class PurchasesController < ApplicationController

  # 商品確認ページの表示
  def show
    @item = Item.find(params[:id])
    redirect_to root_path if @item.seller_id == current_user.id
  end

  def update
    @item = Item.find(params[:id])
    @user = User.find(current_user.id)
    @credit = Credit.find(@user.credit.id)
    Payjp.api_key = ENV['PAYJP_SECRET_ACCESS_KEY']
    Payjp::Charge.create(currency: 'jpy', amount: @item.price, customer: @credit.customer_id)
    @item.update(status: 4, buyer_id: current_user.id)
    redirect_to root_path, notice: "購入が完了しました"
  end

end
