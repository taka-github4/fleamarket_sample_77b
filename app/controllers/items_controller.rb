class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.photos.new
    @parents = Category.all.order("id ASC").limit(1)
    render layout: false
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @parents = Category.all.order("id ASC").limit(1)
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
        @children = Category.find_by(params[:id]).children
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