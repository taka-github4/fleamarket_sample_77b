class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_parents, only: [:index,:show]

  def index
  end

  def show
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
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
