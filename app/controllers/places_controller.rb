class PlacesController < ApplicationController
before_action :set_place, only: [:show]
  def index
  end

  def show
    @map_adress = "https://maps.googleapis.com/maps/api/staticmap?center=" + ERB::Util.url_encode(@place.street) + "," +@place.zip + "," + @place.country + "&zoom=15&size=600x450&markers=color:blue%7Clabel:B%7C" + ERB::Util.url_encode(@place.street) + "," +@place.zip + "," + @place.country + "&key=AIzaSyC9UoMUTh9A1Wq0-u58BkwufyMwvOhEB0E" 
  end
  
  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = params[:city]
      render :index
    end
  end

  private

  def set_place
    @place = BeermappingApi.places_in(session[:city]).find { |place| place.id == params[:id] }
  end
end
  
