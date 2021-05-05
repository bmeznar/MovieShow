class ApplicationController < ActionController::Base
  if user_signed_in?
    if current_user.subscribed!=true?
      redirect_to '/subscribers/new'
    end
  end
end
