class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @items = @category.set_items
    @items = @items.order("created_at DESC").page(params[:page]).per(8)
  end

private
  def set_category
    @category = Category.find(params[:id])
    if @category.has_children?
      @categorylists = @category.children
    else
      @categorylists = @category.siblings
    end
  end
end
