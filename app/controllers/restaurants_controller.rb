class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update]

  def index
    @search = Restaurant.search(params[:q])
    @restaurants = @search.result.order('name').page(params[:page]).per(15)
  end
  
  def upvote
    unless params[:restaurant_id].nil?
      @restaurant = Restaurant.find(params[:restaurant_id])
      params[:id] = @restaurant
      new_up_vote = @restaurant[:upvote] + 1
      @restaurant.update_attribute(:upvote, new_up_vote)
      respond_to do |format|
 	    format.html { redirect_to @restaurant, notice: 'Thank you for your vote.'} 
 	    format.json { render :show, status: :ok, location: @restaurant } 
 	  end
 	end
  end
  
  def downvote
    unless params[:restaurant_id].nil?
      @restaurant = Restaurant.find(params[:restaurant_id])
      new_down_vote = @restaurant[:downvote] + 1
      @restaurant.update_attribute(:downvote, new_down_vote)
      respond_to do |format|
 	    format.html { redirect_to @restaurant, notice: 'Thank you for your vote.'} 
 	    format.json { render :show, status: :ok, location: @restaurant }
 	  end
 	end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { redirect_to restaurants_url, notice: 'There was an error processing your vote' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :upvote, :downvote)
    end
end
