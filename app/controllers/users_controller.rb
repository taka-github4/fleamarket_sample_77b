class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :logout]

  def index
    redirect_to root_url
  end
  def show
  end
  def logout
  end
end
