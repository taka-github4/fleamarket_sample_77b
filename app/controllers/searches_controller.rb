class SearchesController < ApplicationController
  before_action :set_search

  def index
    @items = @search.result(distinct: true).order(created_at: "DESC").includes(:photos)
  end

end
