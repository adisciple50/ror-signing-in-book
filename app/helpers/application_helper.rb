module ApplicationHelper
  def logged_in?(username,token)
    user = Admin.find_by(username: username, token:token)
    user&.valid?
  end
end
