json.extract! user, :id, :email, :budget, :budget_after_expenses, :created_at, :updated_at
json.services do
  json.array! user.services do |service|
    json.partial! "app_services/app_service", app_service: service.app_service
  end
end
