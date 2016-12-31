module BusinessesHelper

  def favorite_business_link(business, remote: true)
    if current_user.favorite_business?(business)
      link_to(my_business_user_business_path(business.id, business.id), method: :delete, remote: remote) do
         content_tag(:i, class: "material-icons") do
           'add_circle'
         end
      end
    else
      link_to(my_business_user_businesses_path(business.id), method: :post, remote: remote) do
         content_tag(:i, class: "material-icons") do
           'remove_circle'
         end
      end
    end
  end

end
