class UsersController < Clearance::UsersController
  before_action :require_login, only: [:edit, :update]

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = 'Saved successfully'
    end

    render :edit
  end

  private

  def user_from_params
    Clearance.configuration.user_model.new(user_params)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :full_name, :email, :password)
  end
end
