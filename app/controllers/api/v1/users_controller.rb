class API::V1::UsersController < API::V1::ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    encoded_email = Base64.urlsafe_decode64(params[:email])
    @user = User.find_by(email: encoded_email)
    render json: @user
  end
end
