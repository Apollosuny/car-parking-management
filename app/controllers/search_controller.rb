class SearchController < ApplicationController
  def index
    @results = search_for_posts

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
            turbo_stream.update('vehicle_models',
                                partial: 'vehicle_models/vehicle_models',
                                locals: { vehicle_models: @results })
      end
    end
  end

  def search_for_posts
    if params[:query].blank?
      VehicleModel.all
    else
      VehicleModel.search(params[:query], fields: %i[brand], operator: 'or', match: :text_middle)
    end
  end
end