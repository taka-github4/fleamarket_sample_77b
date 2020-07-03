class SearchesController < ApplicationController

  def index
    @search = Item.ransack(params[:q])
    @items = @search.result(distinct: true).order(created_at: "DESC").includes(:photos)
  end

end
