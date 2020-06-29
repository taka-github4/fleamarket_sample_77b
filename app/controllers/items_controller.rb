class ItemsController < ApplicationController
  layout false,only: [:new,:create]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.includes(:photos).order('created_at DESC').limit(4)
  end

  def show
  end

  def new
    @item = Item.new
    @item.photos.new
    @parents = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を出品しました。"
      redirect_to root_path
    else
      @item.photos.new
      @parents = Category.where(ancestry: nil)
      flash.now[:alert] = @item.errors.full_messages
      render :new
    end
  end

  def edit
  end
  def update
  end
  def destroy
  end

  def children
    respond_to do |format|
      format.json do
        @children = Category.find(params[:id]).children
      end
    end
  end


  def grandchildren
    respond_to do |format|
      format.json do
        @grandchildren = Category.find(params[:id]).children
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,  :price, :size_id, :category_id,:description, :item_condition_id, :burden_id, :prefectures_id, :days_id, :brand,  photos_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

end