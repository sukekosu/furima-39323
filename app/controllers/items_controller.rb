class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def update
      if @item.update(item_params)
        redirect_to item_path(params[:id])
      else
        render :edit
      end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :describe, :category_id, :status_id, :delv_fee_id, :ship_from_id, :delv_days_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end