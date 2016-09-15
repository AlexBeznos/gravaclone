class API::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :doorkeeper_authorize!

  private

  def record_not_found
    render json: { error: 'Not Found' }, status: :not_found
  end
end
