class SuggestionsController < ApplicationController

   def index
     @sic_codes = SicCode.order(:name).where("name ilike ?", "%#{params[:term]}%").order(name: :asc).limit(10)
     render json: @sic_codes.map(&:name)
   end

end
