class ProfileController < ApplicationController
  def edit
    @user = current_user
  end
  
  def update
    user = params[:user]
    @user = current_user
    @user.password = user[:password] if user[:password] == user[:password_confirmation] and user[:password].present? and user[:password_confirmation].present?
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
