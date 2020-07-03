class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :logout]
  before_action :set_parents, only: [:show, :logout]
  before_action :set_search, except: :index

  def index
    redirect_to root_url
  end
  def show
  end
  def logout
  end
  
  private

  def set_search
    @search = Item.ransack(params[:q])
  end
  
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end

