class UsersController < Clearance::UsersController

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      render :edit, notice: 'Saved successfully'
    else
      render :edit
    end
  end

  private

  def user_from_params
    Clearance.configuration.user_model.new(user_params)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :full_name, :email, :password)
  end
end
