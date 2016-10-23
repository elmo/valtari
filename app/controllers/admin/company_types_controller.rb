class Admin::CompanyTypesController < ApplicationController
  before_action :set_company_type, only: [:show, :edit, :update, :destroy]

  def index
    @company_types = CompanyType.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @company_type = CompanyType.new
  end

  def edit
  end

  def create
    @company_type = CompanyType.new(company_type_params)

    respond_to do |format|
      if @company_type.save
        format.html { redirect_to admin_company_type_path(@company_type), notice: 'Company type was successfully created.' }
        format.json { render :show, status: :created, location: @company_type }
      else
        format.html { render :new }
        format.json { render json: @company_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company_type.update(company_type_params)
        format.html { redirect_to admin_company_type_path(@company_type), notice: 'Company type was successfully created.' }
        format.json { render :show, status: :ok, location: @company_type }
      else
        format.html { render :edit }
        format.json { render json: @company_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_company_types_url, notice: 'Company type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_company_type
      @company_type = CompanyType.find(params[:id])
    end


    def company_type_params
      params.require(:company_type).permit(:name, :category)
    end
end
