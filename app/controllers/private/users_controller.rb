class Private::UsersController < Private::PrivateController
  before_action :set_cim
  before_action :set_user, only: [:show, :edit, :update, :destroy, :client, :remove_client]

  def index
    scope = @cim.cim_authorizations.where(cim_authorizations: {cim_id: @cim.id } )
    if !current_user.admin? and !current_user.client_for_cim?(cim: @cim )
      scope = scope.joins(:user).where(["users.email like ? ", current_user.email.split('@').last ])
    end
    @users = scope.collect(&:user)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = @cim.create_user_for_cim(email: user_params[:email] )
    respond_to do |format|
      if @user.persisted?
        format.html { redirect_to private_cim_users_path(@cim) , notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to private_cim_user_path(@user), notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to private_cim_users_url, notice: 'User was successfully destroyed.' }
    end
  end

  def remove
    user = User.find(params[:user_id])
    user.deauthorized_for_cim!(cim: @cim)
    redirect_to private_cim_users_url(@cim)
  end

  def client
    @user.client_for_cim!(cim: @cim)
    redirect_back(fallback_location: private_cim_users_path(@cim), notice: "User #{@user.email} is now a client for this cim." )
  end

  def remove_client
    @user.remove_client_from_cim!(cim: @cim)
    redirect_back(fallback_location: private_cim_users_path(@cim), notice: "User #{@user.email} is no longer a client for this cim." )
  end

  private

    def set_cim
      @cim = Cim.friendly.find(params[:cim_id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:email)
    end
end
