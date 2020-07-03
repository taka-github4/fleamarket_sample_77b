class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :logout, :favorite]

  def index
    redirect_to root_url
  end
  def show
  end
  def logout
  end
end

