class ApplicationController < ActionController::API

  def authenticate
    token = request.headers['Authorization']&.split(' ')&.last
    return show_unauthorized unless token.present?

    user = User.from_jwt(token)
    return show_unauthorized unless user.present?

    @current_user = user
  end

  def show_unauthorized
    render json: { errors: 'Token not found' }, status: :unauthorized
  end
end
