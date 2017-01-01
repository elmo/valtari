class My::SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def index
    @searches = current_user.searches.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to  edit_my_search_path(@search) , notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to my_searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_search
      @search = current_user.searches.find(params[:id])
    end

    def search_params
      params.require(:search).permit(:name)
    end
end
