class Admin::BusinessesController < Admin::AdminController
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  # GET /businesses
  # GET /businesses.json
  def index
    params[:division1] = 'United States and Canada'
    scope = Business
    q = params[:q]
    ordering = "lower(company_name) asc"
    current_sort_direction = params[:sort_direction] || 'desc'
    @sort_direction = current_sort_direction == 'desc' ? 'asc' : 'desc'
    if q =~ /\@/ # input is an email address
      scope = scope.where(email: q)
    elsif q =~ /\d/ # input contains a digit
      scope =  scope.where(['phone = ?',   q.gsub(/\D/, '')])
    elsif q.present?
      scope = scope.where(['lower(company_name) like ? ', '%' + q.downcase + '%'])
    end

    scope = scope.within_division1( params[:division1] ) if params[:division1].present?
    scope = scope.within_division2( params[:division2] ) if params[:division2].present?
    scope = scope.within_division3( params[:division3] ) if params[:division3].present?
    scope = scope.within_division4( params[:division4] ) if params[:division4].present?
    scope = scope.within_division5( params[:division5] ) if params[:division5].present?
    scope = scope.matching_company(params[:company_name]) if params[:company_name].present?
    scope = scope.within_city(params[:city] ) if params[:city].present?
    scope = scope.within_state(params[:state] ) if params[:state].present?
    scope = scope.within_country(params[:country] ) if params[:country].present?
    scope = scope.within_postal_code(params[:postal_code] ) if params[:postal_code].present?
    scope = scope.ready if params[:duplication_status].present? and params[:duplication_status] == 'ready'
    scope = scope.ok if params[:duplication_status].present? and params[:duplication_status] == 'ok'
    scope = scope.dupe if params[:duplication_status].present? and params[:duplication_status] == 'dupe'

    scope = scope.with_email if params[:with_email].present?
    scope = scope.with_phone if params[:with_phone].present?
    scope = scope.with_address if params[:with_address].present?
    scope = scope.with_city if params[:with_city].present?
    scope = scope.with_state if params[:wiht_state].present?
    scope = scope.with_country if params[:with_country].present?
    scope = scope.with_contact_first_name if params[:with_contact_first_name].present?
    scope = scope.with_contact_last_name if params[:with_contact_last_name].present?
    scope = scope.with_contact_title if params[:with_contact_title].present?
    scope = scope.with_website if params[:with_website].present?
    scope = scope.with_revenue if params[:with_revenue].present?
    scope = scope.with_number_of_employees if params[:with_number_of_employees].present?
    scope = scope.with_naics_code if params[:with_naics_code].present?
    scope = scope.with_sic_code if params[:with_sic_code].present?
    scope = scope.with_parent_company if params[:with_parent_company].present?
    scope = scope.with_geo_id if params[:wiht_geo_id].present?
    scope = scope.with_division1 if params[:with_division1].present?
    scope = scope.with_division2 if params[:with_division2].present?
    scope = scope.with_division3 if params[:with_division3].present?
    scope = scope.with_division4 if params[:with_division4].present?
    scope = scope.with_division5 if params[:with_division5].present?

    scope = scope.without_email if params[:without_email].present?
    scope = scope.without_phone if params[:without_phone].present?
    scope = scope.without_address if params[:without_address].present?
    scope = scope.without_city if params[:without_city].present?
    scope = scope.without_state if params[:without_state].present?
    scope = scope.without_country if params[:without_country].present?
    scope = scope.without_contact_first_name if params[:without_contact_first_name].present?
    scope = scope.without_contact_last_name if params[:without_contact_last_name].present?
    scope = scope.without_contact_title if params[:without_contact_title].present?
    scope = scope.without_website if params[:without_website].present?
    scope = scope.without_revenue if params[:without_revenue].present?
    scope = scope.without_number_of_employees if params[:without_number_of_employees].present?
    scope = scope.without_naics_code if params[:without_naics_code].present?
    scope = scope.without_sic_code if params[:without_sic_code].present?
    scope = scope.without_parent_company if params[:without_parent_company].present?
    scope = scope.without_geo_id if params[:without_geo_id].present?
    scope = scope.without_division1 if params[:without_division1].present?
    scope = scope.without_division2 if params[:without_division2].present?
    scope = scope.without_division3 if params[:without_division3].present?
    scope = scope.without_division4 if params[:without_division4].present?
    scope = scope.without_division5 if params[:without_division5].present?

    # Sort
    if params[:sort].present?
      ordering = "company_name #{current_sort_direction}" if params[:sort] == 'company-name'
      ordering = "contact_title  #{current_sort_direction}" if params[:sort] == 'title'
      ordering = "contact_first_name #{current_sort_direction}" if params[:sort] == 'first-name'
      ordering = "contact_last_name #{current_sort_direction}" if params[:sort] == 'last-name'
      ordering = "phone #{current_sort_direction}" if params[:sort] == 'phone'
      ordering = "email #{current_sort_direction}" if params[:sort] == 'email'
      ordering = "website #{current_sort_direction}" if params[:sort] == 'website'
      ordering = "number_of_employees #{current_sort_direction}" if params[:sort] == 'employees'
      ordering = "naics_code #{current_sort_direction}" if params[:sort] == 'naisc'
      ordering = "sic_code #{current_sort_direction}" if params[:sort] == 'sic'
      ordering = "description #{current_sort_direction}" if params[:sort] == 'description'
      ordering = "address #{current_sort_direction}" if params[:sort] == 'address'
      ordering = "city #{current_sort_direction}" if params[:sort] == 'city'
      ordering = "state #{current_sort_direction}" if params[:sort] == 'state'
      ordering = "postal_code #{current_sort_direction}" if params[:sort] == 'zip'
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
        format.html { redirect_to admin_business_path(@business), notice: 'Business was successfully created.' }
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
     Logidze.with_responsible(current_user.id) do
        if @business.update_attributes(business_params)
          format.html { redirect_to admin_business_path(@business), notice: 'Business was successfully updated.' }
          format.json { respond_with_bip(@business) }
        else
          format.html { render :edit }
          format.json { respond_with_bip(@business) }
        end
      end
    end
  end

  def dupe
     @business = Business.find(params[:business_id])
     @business.dupe!(user: current_user)
     redirect_back(fallback_location: admin_businesses_path)
  end

  def undupe
     @business = Business.find(params[:business_id])
     @business.undupe!(user: current_user)
     redirect_back(fallback_location: admin_businesses_path)
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to admin_businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export
    @businesses = Business.all
    respond_to do |format|
      format.csv do
        send_data @businesses.to_csv, filename: "export-#{Time.zone.now}.csv"
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
      @business.last_updated_by_user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:company_name, :contact_first_name, :contact_last_name, :contact_title, :phone, :email, :website, :revenue, :number_of_employees, :naics_code, :sic_code, :industry_classification, :description, :address, :city, :state, :country, :postal_code, :status)
    end
end
