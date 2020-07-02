class ItemsController < ApplicationController
  layout 'no-header',only: [:new,:create,:edit,:update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,:destroy]
  before_action :set_item,only:[:edit,:update,:destroy]
  before_action :not_useritem,only:[:edit,:update,:destroy]

  def index
    @items = Item.all.includes(:photos).order('created_at DESC').limit(4)
    @parents = Category.where(ancestry: nil)
  end

  def show
    @item = Item.find(params[:id])
    @parents = Category.where(ancestry: nil)
    @category = Category.find(@item.category_id)
    @items = @category.set_items
    @items = @items.order("created_at DESC").limit(6)
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
    @item.photos.new
    @parent = @item.category.parent.parent_id
    @child = @item.category.parent_id
    @parents = Category.where(ancestry: nil)
    @children = Category.where(ancestry: "#{@parent}")
    @grandchildren = Category.where(ancestry: "#{@parent}/#{@child}")
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "商品情報を更新しました。"
      redirect_to root_path
    else
      flash.now[:alert] = @item.errors.full_messages
      @item = Item.find(params[:id])
      @item.photos.new
      @parent = @item.category.parent.parent_id
      @child = @item.category.parent_id
      @parents = Category.where(ancestry: nil)
      @children = Category.where(ancestry: "#{@parent}")
      @grandchildren = Category.where(ancestry: "#{@parent}/#{@child}")
      render :new
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "商品を削除しました。"
    redirect_to root_url
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

  def set_item
    @item = Item.find(params[:id])
  end

  def not_useritem
    if @item.user_id != current_user.id
      redirect_to root_url
    end
  end
end

