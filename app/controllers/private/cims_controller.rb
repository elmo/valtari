class Private::CimsController < ApplicationController
  before_action :set_devise_mapping
  before_action :authenticate_user!
  layout 'cim'

  before_action :set_cim, only: [:show, :edit, :update, :destroy]

  def index
    @cims = Cim.all
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data(@cim.pdf.read, filename: @cim.name.dasherize + ".pdf" , disposition: 'inline', type: 'application/pdf')
      end
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
        format.html { redirect_to private_cim_path(@cim) , notice: 'Cim was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @cim.update(cim_params)
        format.html { redirect_to private_cim_path(@cim), notice: 'Cim was successfully updated.' }
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

    def set_cim
      @cim = Cim.friendly.find(params[:id])
    end

    def cim_params
      params.require(:cim).permit(:name,:html,:pdf)
    end

  def set_devise_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

end
