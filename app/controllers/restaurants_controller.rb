class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update]
  before_action :set_votes, only: [:show, :update]
  before_action :set_comments, only: [:show, :update, :create]

  def index
    @search = Restaurant.search(params[:q])
    @restaurants = @search.result.order('name').page(params[:page]).per(15)
    @votes = Vote
    #@comments = Comment.where(:restaurant_id => @restaurant.id)
  end
  
  def upvote
    unless params[:restaurant_id].nil?
      @restaurant = Restaurant.find(params[:restaurant_id])
      params[:id] = @restaurant
      
      @newVote = Vote.create!(vote: true, user_id: current_user.id, restaurant_id: @restaurant.id) 
      
      respond_to do |format|
 	    format.html { redirect_to @restaurant, notice: 'Thank you for your vote.'} 
 	    format.json { render :show, status: :ok, location: @restaurant } 
 	  end
 	end
  end
  
  def downvote
    unless params[:restaurant_id].nil?
      @restaurant = Restaurant.find(params[:restaurant_id])
      
      @newVote = Vote.create!(vote: false, user_id: current_user.id, restaurant_id: @restaurant.id) 
      
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
    
    def set_votes
      @votes = Vote.all
    end
    
    def set_comments
      @comments = Comment.where(:restaurant_id => @restaurant.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :city, :state, :zip)
    end
end
