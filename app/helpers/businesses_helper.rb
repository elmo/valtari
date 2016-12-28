module BusinessesHelper

  def favorite_business_link(business)
    if current_user.favorite_business?(business)
      link_to(my_business_user_business_path(business.id, business.id), method: :delete, remote: true) do
         content_tag(:i, class: "material-icons") do
           'visibility_on'
         end
      end
    else
      link_to(my_business_user_businesses_path(business.id), method: :post, remote: true) do
         content_tag(:i, class: "material-icons") do
           'visibility_off'
         end
      end
    end
  end

end
