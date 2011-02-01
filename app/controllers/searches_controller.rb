class SearchRequest
  include HTTParty
  basic_auth Rails.env["HTTP_HOST"], GOOGLE_IMAGE_SEARCH_API_KEY
end

class SearchesController < ApplicationController

  before_filter :authenticate_user!

  def create
    gis_url = GOOGLE_IMAGE_SEARCH_ENDPOINT
    gis_url += URI.escape(params[:search_value])
    
    s = SearchRequest.get gis_url
    results = s["responseData"]["results"]
    render :json => results
  end
end
