require 'openai'

class OpenAIProcessorService
  CLIENT = OpenAI::Client.new(
    access_token: ENV["OPENAI_API_KEY"],
    log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
  )

  def self.analyze_email(email)
    return if email.processed_email.present?
    response = CLIENT.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "Extract vendor details, inventory, and order summary from the email. If there is an action that a person needs to do, include it as Need Attention, if there is an action like create, delete, update include it as Action. If there is no information about a vendor return Vendor as nil, and if there is no information about inventory return Inventory as nil." },
          { role: "user", content: email.body }
        ]
      }
    )

    message_content = response.dig("choices", 0, "message", "content").strip
    ProcessedEmail.create!(ai_response: message_content, email: email)
  rescue => e
    Rails.logger.error "OpenAI Error: #{e.message}"
    nil
  end
end