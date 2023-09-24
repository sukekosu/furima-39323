class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :items_user
  before_action :sold_order

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,           # 商品の値段
      card: order_params[:token],    # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end

  def items_user
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_address).permit(:post_code, :ship_from_id, :city, :address, :building_name, :tel_num).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def sold_order
    if @item.orders.present?
      redirect_to root_path
    end
  end

end
