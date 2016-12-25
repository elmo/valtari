module BusinessesHelper

  def favorite_business_link(business)
    if current_user.favorite_business?(business)
      link_to 'remove', my_business_user_business_path(business.id, business.id), method: :delete, remote: true
    else
      link_to 'add', my_business_user_businesses_path(business.id), method: :post, remote: true
    end
  end

end
