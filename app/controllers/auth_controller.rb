class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :login, :signup ]

  def signup
    @user = User.new(user_params)
    if @user.save
      render json: { message: "User created successfully", user: @user }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_for_database_authentication(email: params[:email])
    if @user&.valid_password?(params[:password])
      render json: { token: @user.jwt_token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
