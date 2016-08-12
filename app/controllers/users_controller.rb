class UsersController < ApplicationController
  def new
  end

  def create
    p params[:user]
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @errors = @user.errors.full_messages
      render new_user_path
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end