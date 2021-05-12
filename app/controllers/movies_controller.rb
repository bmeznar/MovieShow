class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  # GET /movies or /movies.json
  def index
    if user_signed_in?
      if !current_user.subscribed
        redirect_to new_subscriber_path
      end
    end
    @trailers = Trailer.all
    @movies = Movie.all
  end

  # GET /movies/1 or /movies/1.json
  def show
    if user_signed_in?
      if !current_user.subscribed
        redirect_to new_subscriber_path
      end
    end
    @watchlist_exists = Watchlist.where(movie: @movie, user: current_user) == [] ? false : true
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:movie_id, :title, :release_date, :backdrop_path, :poster_path, :overview, :average_vote, :buget, :tegline, :tegline)
    end
end
