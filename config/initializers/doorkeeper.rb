Doorkeeper.configure do
  enable_application_owner confirmation: true
  resource_owner_authenticator do
    @user = env[:clearance].current_user

    unless @user
      session[:return_to] = request.fullpath
      redirect_to(sign_in_url)
    end

    @user
  end
end
