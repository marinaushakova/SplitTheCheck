class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :destroy]

  respond_to :html

  def index
    @favorites = Favorite.all
    respond_with(@favorites)
  end

  def show
    respond_with(@favorite)
  end

  def new
    @favorite = Favorite.new
    respond_with(@favorite)
  end

  def edit
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.save
    respond_with(@favorite)
  end

  def update
    @favorite.update(favorite_params)
    respond_with(@favorite)
  end

  def destroy
    @favorite.destroy
    respond_with(@favorite)
  end

  private
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    def favorite_params
      params.require(:favorite).permit(:user_id, :restaurant_id)
    end
end
