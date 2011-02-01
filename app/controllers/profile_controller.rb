class ProfileController < ApplicationController
  def edit
    @user = current_user
  end
  
  def update
    user = params[:user]
    @user = current_user
    @user.email = user[:email]
    @user.campfire_subdomain = user[:campfire_subdomain]
    @user.campfire_api_key = user[:campfire_api_key]
    @user.campfire_room = user[:campfire_room]
    if @user.save
      flash[:notice] = 'user saved'
      redirect_to profile_edit_path
      return
    end
  end
end
