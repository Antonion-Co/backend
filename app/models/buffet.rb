class Buffet

  def initialize(budget: 0, budget_after_expenses: 0, subscriptions: [], messages: [])
    @budget = budget
    @subscriptions = subscriptions
    @messages = messages

    @client = OpenAI::Client.new(access_token: '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')
  end

  def ask(content)
    response = @client.chat(parameters: {
      model: "gpt-4",
      messages: [
        {
          role: 'system',
          content: build_system_prompt
        },
        *@messages.map { |message| { role: message[:sender] == 1 ? 'user' : 'assistant', content: message[:content] } },
        *[{ role: 'user', content: content }]
      ]
    })

    json_response = response.dig("choices", 0, "message", "content")
    JSON.parse(json_response)
  end

  def build_system_prompt
    # read the file inside <root>/lib/prompts/chat_system.txt
    file = File.open("#{Rails.root}/lib/prompts/chat_system.txt")
    file_data = file.read
    file.close

    # replace the placeholder with the user's message
    file_data.gsub!("<user_budget>", @budget.to_s)
    file_data.gsub!("<user_subscriptions>", build_subscriptions_prompt)

    file_data
  end

  def build_subscriptions_prompt
    # read the file inside <root>/lib/prompts/chat_system.txt
    prompt_array = []

    file = File.open("#{Rails.root}/lib/prompts/subscription.txt")
    file_data = file.read
    file.close

    # replace the placeholder with the user's message
    @subscriptions.each do |subscription|
      prompt_array << file_data.gsub("<subscription_name>", subscription[:name]).gsub("<subscription_price>", subscription[:price].to_s)
    end

    prompt_array.join("\n")
  end
end