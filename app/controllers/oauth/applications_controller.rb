class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  include Clearance::Controller
  layout 'application'
  before_action :require_login

  def index
    @applications = current_user.oauth_applications.select(:id, :name)
  end

  def new
    @application = ClientApplication.new
  end

  def create
    @application = ClientApplication.new(application_params)
    @application.owner = current_user if Doorkeeper.configuration.confirm_application_owner?
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  private

  def set_application
    @application = current_user.oauth_applications.find(params[:id])
  end

  def application_params
    params.require(:client_application).permit(:name, :redirect_uri, :scopes, :user_update_url)
  end

end
