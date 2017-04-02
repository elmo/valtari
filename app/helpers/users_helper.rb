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

  def following_user_link(other_user, remote: true)
    if current_user.following?(other_user)
      link_to(my_following_path(id: other_user.id), method: :delete, remote: remote) do
         content_tag(:i, class: "ion-person-add") do
         end
      end
    else
      link_to(my_followings_path(id: other_user.id), method: :post, remote: remote) do
         content_tag(:i, class: "ion-ios-close-outline") do
         end
      end
    end
  end

  def public_profile_link(user)
    link_to user.name, user_path(user)
  end

  def user_interests(user)
     user.user_industry_classifications.collect(&:industry_classification).collect(&:name).join(',')
  end

end
