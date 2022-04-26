class AuthenticationController < ApplicationController
  #TODO - redirects to admin page regardless of successful login

  def login
    if logged_in?
      # flash.alert "Incorrect Login or Password"
      redirect_to entries_path ,alert: "Successfully Logged In"
    end
  end

  def authenticate
    if login!(params["username"],params["password"])
      # flash.alert "Incorrect Login or Password"
      redirect_to entries_path ,alert: "Successfully Logged In"
    else
      redirect_to :controller => :authentication,action: :login,alert: "Incorrect Username or Password" # calls this when true? whats going on!
    end
  end
  def logout
    logout!(session["username"])
    redirect_to root_url
  end

  private
  def authentication_params
    params.require(:authentication).permit(:username, :password,:token)
  end

  def generate_unique_token
    return SecureRandom::uuid
  end

  # quick and dirty workaround to save and update not working
  # only to be used for authenticated users!
  def update_token(username,new_token)
    ActiveRecord::Base.connection.execute("UPDATE admins SET token = '#{new_token}' WHERE username = '#{username}'")
  end

  def logout!(username)
    ActiveRecord::Base.connection.execute("UPDATE admins SET token = NULL WHERE username = '#{username}'")
  end

  def login!(username,password)
    user = Admin.find_by(username:username)
    if user
      if user.authenticate(password)
        unique_token = generate_unique_token
        update_token username,unique_token # i could use user.username but i wont because i think its quicker
        session["username"] = user.username
        session["token"] =  unique_token
        return true
      else
        return false
      end
    end
    # true
  end

  end
  def log_out!(username)
    user = Admin.find_by(username:username)
    logged_out_token = 'logged_out'
    if user
      update_token user.username,logged_out_token
      session["username"] = logged_out_token
      session["token"] = logged_out_token
    end
  end
