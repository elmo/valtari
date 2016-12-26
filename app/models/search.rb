class Search < ApplicationRecord
  belongs_to :user

  def self.search_name(params)
    name = ''
    name = params[:division1] if params[:division1].present?
    name = params[:division2] if params[:division2].present?
    name = params[:division3] if params[:division3].present?
    name = params[:division4] if params[:division4].present?
    name = params[:division5] if params[:division5].present?
    name += " : #{params[:q]}" if params[:q].present?
    name
  end

end
