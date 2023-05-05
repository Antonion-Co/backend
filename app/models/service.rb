class Service < ApplicationRecord
  belongs_to :app_service
  belongs_to :user

  # user can only have one service per app_service
  validates :app_service_id, uniqueness: { scope: :user_id, message: "the user already has this service" }
end
