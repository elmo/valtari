class Private::CimsController < Private::PrivateController
  before_action :set_cim, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, only: [:index, :edit, :update, :destroy]
  before_action :check_authorization, except: [:welcome]
  after_action :log_access, only: [:show]

  def index
    @cims = Cim.all
  end

  def show
    respond_to do |format|
      format.html {render tempate: 'show', layout: false}
      format.pdf do
        send_data(@cim.pdf.read, filename: @cim.name.dasherize + ".pdf" , disposition: 'inline', type: 'application/pdf')
      end
    end
  end

  def welcome
  end

  def teaser
   respond_to do |format|
     format.html {render tempate: 'teaser', layout: 'cim-teaser'}
   end
  end

  def new
    @cim = Cim.new
  end

  def edit
  end

  def create
    @cim = Cim.new(cim_params)

    respond_to do |format|
      if @cim.save
        format.html { redirect_to edit_private_cim_path(@cim) , notice: 'Cim was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @cim.update(cim_params)
        format.html { redirect_to edit_private_cim_path(@cim), notice: 'Cim was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @cim.destroy
    respond_to do |format|
      format.html { redirect_to private_cims_url, notice: 'Cim was successfully destroyed.' }
    end
  end

  private

  def admin_only
    not_found unless current_user.admin?
  end

  def set_cim
    @cim = Cim.friendly.find(params[:id])
  end

  def cim_params
    params.require(:cim).permit(:name,:html,:pdf)
  end

  def log_access
    CimAccess.create!(user: current_user, cim: @cim, ip: request.remote_ip)
  end

end
