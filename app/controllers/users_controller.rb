class UsersController < ApplicationController
  before_filter :authenticate_admin!
  
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_tables, only: [:new, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.joins(:user_group).order('user_groups.sort_order ASC, last_name asc, first_name ASC')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:message] = "User has been created"
        format.html { redirect_to edit_user_path(@user) }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:message] = "User has been updated"
        format.html { redirect_to edit_user_path(@user) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:message] = "User has been deleted"
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_tables
      @tables = UserGroup.all.order('sort_order')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:title, :first_name, :last_name, :pin, :user_group_id)
    end
end
