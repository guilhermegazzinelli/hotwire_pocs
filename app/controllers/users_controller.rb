class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_user_address
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_user_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, user_address_attributes: [:id, :state, :city, :zip_code, :other])
  end
end
