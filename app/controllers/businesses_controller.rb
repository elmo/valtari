class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  # GET /businesses
  # GET /businesses.json
  def index
    scope = Business
    q = params[:q]
    ordering = { created_at: :asc }
    current_sort_direction = params[:sort_direction] || 'desc'
    @sort_direction = current_sort_direction == 'desc' ? 'asc' : 'desc'
    if q =~ /\@/ # input is an email address
      scope = scope.where(email: q)
    elsif q =~ /\d/ # input contains a digit
      scope =  scope.where(['phone = ?',   q.gsub(/\D/, '')])
    else
      scope = scope.where(['lower(company_name) like ? ', '%' + q.downcase + '%'])
    end
    # Sort
    if params[:sort].present?
      ordering = "company_name #{current_sort_direction}" if params[:sort] == 'company-name'
      ordering = "contact_last_name #{current_sort_direction}" if params[:sort] == 'owner-ceo'
      ordering = "phone #{current_sort_direction}" if params[:sort] == 'phone'
      ordering = "email #{current_sort_direction}" if params[:sort] == 'email'
      ordering = "revenue #{current_sort_direction}" if params[:sort] == 'revenue'
      ordering = "number_of_employees #{current_sort_direction}" if params[:sort] == 'employees'
      ordering = "industry_classification #{current_sort_direction}" if params[:sort] == 'industry'
      ordering = "city #{current_sort_direction}" if params[:sort] == 'city'
      ordering = "state #{current_sort_direction}" if params[:sort] == 'state'
      ordering = "country #{current_sort_direction}" if params[:sort] == 'country'
      ordering = "updated_at #{current_sort_direction}" if params[:sort] == 'updated'
    end
    @businesses = scope.page(params[:page]).order(ordering).per(10)
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { respond_with_bip(@business) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@business) }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:company_name, :contact_first_name, :contact_last_name, :contact_title, :phone, :email, :website, :revenue, :number_of_employees, :naics_code, :sic_code, :industry_classification, :description, :address, :city, :state, :country, :postal_code, :status)
    end
end
