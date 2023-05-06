class MessagesController < ApplicationController
  before_action :authenticate!, only: [:create]

  def create
    messages = message_params

    buffet = Buffet.new(
      budget: @current_user.budget,
      subscriptions: @current_user.services.map { |service| { name: service.app_service.name, price: service.app_service.price } },
      messages: messages
    ).ask(messages.last[:content])

    @current_user.perform_intent(buffet.dig('intent', 'name'), buffet.dig('intent', 'params'))

    render json: buffet
  end

  private

  def message_params
    params.require(:messages)
  end
end
