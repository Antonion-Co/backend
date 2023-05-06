class AppServicesController < ApplicationController
  def index
    @app_services = AppService.all
  end

  def create
    @app_service = AppService.new(app_service_params)
    if @app_service.save
      render :show, status: :created
    else
      render json: @app_service.errors, status: :unprocessable_entity
    end
  end

  private

  def app_service_params
    params.require(:app_service).permit(:name, :price)
  end
end
