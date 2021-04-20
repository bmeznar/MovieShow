class WatchlistsController < ApplicationController
  #def index
  #end

  def update
    watchlist = Watchlist.where(movie: Movie.find(params[:movie]), user: current_user)
    if watchlist == []
      Watchlist.create(movie: Movie.find(params[:movie]), user: current_user)
      @watchlist_exists = true
    else
      watchlist.destroy_all
      @watchlist_exists = false
    end
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end
end
