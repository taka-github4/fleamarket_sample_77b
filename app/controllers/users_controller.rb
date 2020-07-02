class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :logout]
  before_action :set_parents, only: [:show, :logout]

  def index
    redirect_to root_url
  end
  def show
  end
  def logout
  end

  private
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end