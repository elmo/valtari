class Admin::EbidtaController < Admin::AdminController
  before_action :set_ebidtum, only: [:show, :edit, :update, :destroy]

  # GET /ebidta
  # GET /ebidta.json
  def index
    @ebidta = Ebidtum.all
  end

  # GET /ebidta/1
  # GET /ebidta/1.json
  def show
  end

  # GET /ebidta/new
  def new
    @ebidtum = Ebidtum.new
  end

  # GET /ebidta/1/edit
  def edit
  end

  # POST /ebidta
  # POST /ebidta.json
  def create
    @ebidtum = Ebidtum.new(ebidtum_params)

    respond_to do |format|
      if @ebidtum.save
        format.html { redirect_to @ebidtum, notice: 'Ebidtum was successfully created.' }
        format.json { render :show, status: :created, location: @ebidtum }
      else
        format.html { render :new }
        format.json { render json: @ebidtum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ebidta/1
  # PATCH/PUT /ebidta/1.json
  def update
    respond_to do |format|
      if @ebidtum.update(ebidtum_params)
        format.html { redirect_to @ebidtum, notice: 'Ebidtum was successfully updated.' }
        format.json { render :show, status: :ok, location: @ebidtum }
      else
        format.html { render :edit }
        format.json { render json: @ebidtum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ebidta/1
  # DELETE /ebidta/1.json
  def destroy
    @ebidtum.destroy
    respond_to do |format|
      format.html { redirect_to ebidta_url, notice: 'Ebidtum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebidtum
      @ebidtum = Ebidtum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ebidtum_params
      params.require(:ebidtum).permit(:name)
    end
end
