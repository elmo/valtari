class CimFailure < Devise::FailureApp

  def redirect_url
    return '/private/sessions/new'
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end

end
