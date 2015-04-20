class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]
  before_action :set_comments, only: [:show]
  before_action :set_votes, only: [:show]
  before_action :set_restaurants, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
    else
      respond_to do |format|
        format.html { redirect_to restaurants_url, notice: 'You do not have permission to view this page' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if current_user.id == params[:id].to_i
        @user = User.find(params[:id])
      end
    end
    
    def set_comments
      @comments = Comment.where(:user_id => current_user.id)
    end
    
    def set_votes
      @votes = Vote.find_by_sql([%Q{SELECT v.created_at, r.id as rest_id, r.name as name, v.vote
								   FROM votes v JOIN restaurants r ON v.restaurant_id = r.id
								   WHERE v.user_id = ?}, current_user.id])
								   
								   # COUNT(v.vote) as count
								   # GROUP BY r.name, v.vote
								   
      #.find_by_sql([%Q{select r.id as rest_id, r.name as name, 
	#							   count(select * from votes 
	#									 where restaurant_id = rest_id AND user_id = ? AND vote = true) as upvotes,
	#							   count(select * from votes
	#									 where restaurant_id = rest_id AND user_id = ? AND vote = false) as downvotes
	#							   from restaurants r
	#							   where user_id = ?
	#							   group by name; }, current_user.id])
    end
    
    def set_restaurants
      @restaurants = Restaurant.all
      @favorite_restaurants = Restaurant.find_by_sql([%Q{SELECT r.id, r.name, r.address, r.city, r.state, r.zip, f.restaurant_id
														 FROM restaurants r JOIN favorites f ON r.id = f.restaurant_id
														 WHERE f.user_id = ?}, current_user.id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
