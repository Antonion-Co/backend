class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :services, dependent: :destroy

  def to_jwt
    JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def self.from_jwt(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base).first
    find(decoded_token['id'])
  rescue JWT::ExpiredSignature
    nil
  rescue JWT::DecodeError
    nil
  end

  def budget_after_expenses
    budget - services.map(&:app_service).map(&:price).sum
  end

  def perform_intent(intent, params = [])
    case intent
    when 'add_subscription'
      add_subscription(params.dig(0, 'value'))
    when 'remove_subscription'
      remove_subscription(params.dig(0, 'value'))
    when 'none'
    end
  end

  def add_subscription(name)
    service = AppService.find_by(name: name)
    services.create(app_service: service)
  end

  def remove_subscription(name)
    service = AppService.find_by(name: name)
    services.find_by(app_service: service).destroy
  end
end
