class UserController < ApplicationController

  def index

  end

  def create
    user = User.new
    user.email = params[:email]
    user.username = params[:username]
    user.password = params[:password]
    user.device_id = params[:deviceID]
    if user.save
      render json: {status: true}
    else
      render json: {status: false, msg: user.errors.messages }
    end
  end

  def authenticate_mobile_user
    user = User.authenticate(params[:username], params[:password])
    if user
      render json: {status: true}
    else
      render json: {status: false}
    end
  end

end

