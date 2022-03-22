class ApplicationController < ActionController::Base
  private
  def logged_in?
    Admin.find_by(username: session["username"],token:session["token"])# returns nil if not found
  end
  def reject_if_not_authorized
    if not logged_in?
      redirect_to root_url
    end
  end
end
