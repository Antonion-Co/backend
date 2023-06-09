class UsersController < ApplicationController
  before_action :authenticate!, only: [:show]

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 'User created successfully', token: user.to_jwt }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @user = @current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :budget)
  end
end
