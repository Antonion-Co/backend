class SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email])
    if user&.valid_password?(session_params[:password])
      render json: { status: 'User signed in successfully', token: user.to_jwt }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
