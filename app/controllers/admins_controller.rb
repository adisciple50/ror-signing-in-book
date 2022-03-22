class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]
  before_action :reject_if_not_authorized, only: %i[ show edit update destroy logout ]


  # GET /admins or /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1 or /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins or /admins.json
  def create
    @admin = Admin.new(admin_params)
    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully created." }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url, notice: "Admin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def login
    if login!(params["username"],params["password"])
      redirect_to :controller => :entries,action: :index
    else
      redirect_to admins_url
    end
  end
  def logout
    logout!
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:username, :password,:token)
  end

  def generate_unique_token
    @@token = SecureRandom::uuid
    while Admin.find_by(token:@@token)&.exists?
      @@token = SecureRandom::uuid
    end
    return 'test' #TODO - Change this asap
  end

  # quick and dirty workaround to save and update not working
  # only to be used for authenticated users!
  def update_token(username,new_token)
    ActiveRecord::Base.connection.execute("UPDATE admins SET token = '#{@@unique_token}' WHERE username = '#{username}'")
  end

  def login!(username,password)
    @@user = Admin.find_by(username:username)
    if @@user&.authenticate(password)
      # eliminate dup tokens
      @@unique_token = generate_unique_token
      update_token username,@@unique_token
      session["username"] = @@user.username
      session["token"] =  @@unique_token # TODO - NOT WORKING!
      return true
    else
      flash.alert= 'username and password combo is wrong'
      return false
    end

  end
  def log_out!
    user = Admin.find_by(username:session["username"],token:session["token"])
    logged_out_token = nil
    if user&.valid?
      update_token user.username,logged_out_token
      session["username"] = logged_out_token
      session["token"] = logged_out_token
    end
  end
end
