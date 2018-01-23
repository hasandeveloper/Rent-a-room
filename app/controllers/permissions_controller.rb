class PermissionsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @permission=Permission.new
  end

  def create
    @permission=Permission.new(permission_params)
    permission={user: @permission.user_id, role: @permission.role_id}

    if @permission.save_or_exist(permission)
      redirect_to new_permission_path, notice: "This user has been added to role #{@permission.role.name}"
    else
      redirect_to new_permission_path, notice: "This user has been Already Exist To the role #{@permission.role.name}"
    end
  end

  private
  def permission_params
    params[:permission].permit(:user_id, :role_id)
  end
end
