class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def edit
    super
  end

  def create
    super
  end

  def update
    if update_resource(current_user, account_update_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    super
  end

  def cancel
    super
  end

  private

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :organization_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :organization_id)
  end


end
