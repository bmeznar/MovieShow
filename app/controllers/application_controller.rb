class ApplicationController < ActionController::Base
    def watchlist_text
        return @watchlist_exists ? "Remove from Watchlist" : "Add to Watchlist"
    end

    helper_method :watchlist_text
end
