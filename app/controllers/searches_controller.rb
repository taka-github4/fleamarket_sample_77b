class SearchesController < ApplicationController

  def index
    @search = Item.ransack(params[:q])
    @searchParents = Category.where(ancestry: nil)
    @items = @search.result(distinct: true).order(updated_at: "DESC").includes(:photos)
  end

end