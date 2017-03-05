class Admin::DivisionsController < Admin::AdminController

  def index
    @name = params[:name]
    @value = params[:value]
    respond_to do |format|
      format.js
    end
  end

end
