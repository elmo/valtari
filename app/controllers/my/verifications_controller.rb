class My::VerificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_verification, only: [:show, :edit, :update, :destroy]
  before_action :set_business, except: [:index]

  def index
    @verifications = current_user.verifications.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @verification = current_user.verifications.new(business: @business)
    respond_to do |format|
      if @verification.save
        format.html {redirect_back(fallback_location: businesses_path, notice: 'Verification request created.') }
      else
        format.html {render :new }
      end
    end
  end

  # PATCH/PUT /verifications/1
  # PATCH/PUT /verifications/1.json
  def update
    respond_to do |format|
      if @verification.update(verification_params)
        format.html { redirect_to @verification, notice: 'Verification was successfully updated.' }
        format.json { render :show, status: :ok, location: @verification }
      else
        format.html { render :edit }
        format.json { render json: @verification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verifications/1
  # DELETE /verifications/1.json
  def destroy
    @verification.destroy
    respond_to do |format|
      format.html { redirect_to verifications_url, notice: 'Verification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_business
      @business = Business.find(params[:business_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_verification
      @verification = Verification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verification_params
      params.require(:verification).permit(:integer, :assigned_to, :business_id)
    end
end
