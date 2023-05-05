json.app_services do
  json.array! @app_services, partial: "app_services/app_service", as: :app_service
end
