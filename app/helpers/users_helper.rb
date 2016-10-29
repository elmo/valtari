module UsersHelper

  def avatar_image(user)
    if user.avatar.size > 0
       image_tag(user.avatar.url)
     elsif user.picture_url.present?
       image_tag(user.picture_url)
     else
       image_tag('missing.jpg')
    end
  end

end
