class FavoritesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]
  before_action :set_search, only: [:index]
  def index
    @favorites = Favorite.where(user_id:current_user.id)
    
  end

  def create
    @favorite = Favorite.new(user_id: current_user.id, item_id: @item.id)
    if @favorite.save
      return
    else
      @f_error = "お気に入り登録に失敗しました。"
    end
  end
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    if @favorite.destroy
      return
    else
      @f_error = "お気に入り削除に失敗しました。"
    end
  end

 
  private
  def set_item
    @item = Item.find(params[:item_id])
  end
  def set_search
    @search = Item.ransack(params[:q])
  end
end

