class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind:  "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

   def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind:  "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
   end

   def linkedin
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.persisted?
      @user.name = auth.info.name
      @user.avatar = auth.info.image
      @user.first_name = auth.extra.raw_info.firstName
      @user.last_name = auth.extra.raw_info.lastName
      @user.headline = auth.extra.raw_info.headline
      @user.industry = auth.extra.raw_info.industry
      @user.location = auth.extra.raw_info.location.name
      @user.picture_url = auth.extra.raw_info.pictureUrl
      @user.profile_url = auth.extra.raw_info.publicProfileUrl
      @user.save
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind:  "Linkedin") if is_navigational_format?
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
   end

  def failure
    redirect_to root_path
  end

end
