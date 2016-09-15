class API::V1::ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!
end
