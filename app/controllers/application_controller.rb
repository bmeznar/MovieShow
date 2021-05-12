class ApplicationController < ActionController::Base
    def watchlist_text
        return @watchlist_exists ? "Remove from Watchlist" : "Add to Watchlist"
    end
    
    def check_user
        if user_signed_in?
          if !current_user.subscribed
            redirect_to new_subscriber_path
          end
        end
    end
    
    before_action :check_user
    helper_method :watchlist_text
end
