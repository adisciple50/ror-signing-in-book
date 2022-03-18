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
    if login!(params['username'],params['password'])
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
    params.require(:admin).permit(:username, :password)
  end

  def generate_unique_token
    @@token = SecureRandom::uuid
    while User.find_by(token:@@token)&.exists?
      @@token = SecureRandom::uuid
    end
    return @@token
  end

  def login!(username,password)
    @@user = Admin.find_by(username:username)
    if @@user&.authenticate(password)
      # eliminate dup tokens
      @@unique_token = generate_unique_token
      @@user.token = @@unique_token
      @@user.save
      session['username'] = @@user.username
      session['token'] =  @@unique_token
      return true
    else
      flash.alert= 'username and password combo is wrong'
      return false
    end

  end
  def log_out!
    user = Admin.find_by(username:session['username'],token:session['token'])
    if user&.exists?
      user.token = nil
      user.save
      session['username'] = nil
      session['token'] = nil
    end
  end
end
