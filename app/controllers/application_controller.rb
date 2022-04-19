class ApplicationController < ActionController::Base
  private
  def logged_in?
    Admin.find_by(username: session["username"],token:session["token"])# returns nil if not found
  end
  def is_superuser?
    !Admin.where(superuser: true).any? || logged_in?&.superuser
  end
  def reject_if_not_authorized
    if !logged_in?
      redirect_to root_url
    end
  end
  def reject_if_not_superuser
    # not nil returns true! fix this!
    if !Admin.where(superuser: true).any? || !logged_in?&.superuser
      redirect_to root_url
    end
  end
end
