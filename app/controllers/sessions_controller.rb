class SessionsController < ApplicationController

  include UsersHelper

  def new
    @user = User.new

    if logged_in?
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @message = "Incorrect email or password"
      render "new"
    end
  end

  def mobileAuth
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      loginInfo = {loginStatus: "verified"}
      loginInfo[:user_id] = @user.id.to_s
    else
      loginInfo = {loginStatus: "credentials invalid"}
    end

    render json: loginInfo.to_json
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
