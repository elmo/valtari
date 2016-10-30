module UsersHelper

  def avatar_image(user, klass = "")
    if user.avatar.size > 0
       image_tag(user.avatar.url, class: klass)
     elsif user.picture_url.present?
       image_tag(user.picture_url, class: klass)
     else
       image_tag('missing.jpg', class: klass)
    end
  end

end
