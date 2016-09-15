class API::V1::UsersController < API::V1::ApiController
  def index
    @users = User.all
    render json: @users
  end

  def me
    render json: current_resource_owner
  end

  def show
    encoded_email = Base64.urlsafe_decode64(params[:email])
    @user = User.find_by!(email: encoded_email)
    render json: @user
  rescue ArgumentError
    render json: { error: 'Wrong base64 format' }
  end

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
