class ChatController < ApplicationController
  before_filter :authenticate_user!, :setup_campfire
  
  def new
    fp = "#{Rails.root}/tmp/#{Time.now.to_i}.#{params[:url].split('.').last}"

    uri = URI.parse(params[:url])
    Net::HTTP.start(uri.select(:host).first) do |http|
        resp = http.get(uri.select(:path).first)
        open(fp, "wb") do |file|
            file.write(resp.body)
        end
    end
    
    @room.upload fp
    
    File.unlink fp    
    
    render :text => "your co-workers hate you because of <em>#{URI.escape(params[:url].split('/').last)}</em>".html_safe
  end
  
  protected
  
  def setup_campfire
    unless current_user.campfire_subdomain.present? and current_user.campfire_api_key.present?
      render :text => "fail"
      return
    end
    @campfire = Tinder::Campfire.new current_user.campfire_subdomain, :token => current_user.campfire_api_key
    @room = @campfire.find_room_by_name current_user.campfire_room
    if @room.nil?
      @room = @campfire.rooms.first
    end
  end
end
