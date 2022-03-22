module ApplicationHelper
  def logged_in?(username,token)
    Admin.find_by(username: username, token:token)
  end
end
