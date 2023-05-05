class ServicesController < ApplicationController
  before_action :authenticate!, only: [:create]

  def create
    service = Service.new(service_params)
    service.user = @current_user
    if service.save
      render json: { status: 'Service created successfully' }, status: :created
    else
      render json: { errors: service.errors.full_messages }, status: :bad_request
    end
  end

  private

  def service_params
    params.require(:service).permit(:app_service_id)
  end
end
