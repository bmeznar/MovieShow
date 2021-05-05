class ApplicationController < ActionController::Base
    def watchlist_text
        return @watchlist_exists ? "Remove from Watchlist" : "Add to Watchlist"
    end
    if user_signed_in?
        if current_user.subscribed!=true?
          redirect_to '/subscribers/new'
        end
      end

    helper_method :watchlist_text
end
