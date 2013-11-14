class UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  # GET /user_groups
  # GET /user_groups.json
  def index
    @user_groups = UserGroup.all.order(:sort_order)
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
  end

  # GET /user_groups/new
  def new
    @user_group = UserGroup.new
  end

  # GET /user_groups/1/edit
  def edit
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    @user_group = UserGroup.new(user_group_params)

    respond_to do |format|
      if @user_group.save
        flash[:message] = "Table has been created"
        format.html { redirect_to edit_user_group_path(@user_group) }
        format.json { render action: 'show', status: :created, location: @user_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    respond_to do |format|
      if @user_group.update(user_group_params)
        flash[:message] = "Table has been updated"
        format.html { redirect_to edit_user_group_path(@user_group) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    @user_group.destroy
    respond_to do |format|
      format.html { redirect_to user_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :sort_order)
    end
end
