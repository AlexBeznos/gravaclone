class API::V1::UsersController < API::V1::ApiController
  after_action :create_footprint

  def index
    @users = User.all
    render json: @users
  end

  def me
    @user = current_resource_owner
    render json: @user
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

  def create_footprint
    Footprint.find_or_create_by!(
      user: @user,
      application_id: doorkeeper_token.application_id
    )
  end
end
