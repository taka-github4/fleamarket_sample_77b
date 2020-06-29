class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @items = @category.set_items
    @items = @items.where(purchaser_id: nil).order("created_at DESC")
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
