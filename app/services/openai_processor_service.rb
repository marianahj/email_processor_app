require 'openai'

class OpenAIProcessorService
  CLIENT = OpenAI::Client.new(
    access_token: ENV["OPENAI_API_KEY"],
    log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
  )

  def self.analyze_email(email_text)
    response = CLIENT.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "Extract vendor details, inventory, and order summary from the email." },
          { role: "user", content: email_text }
        ]
      }
    )

    response.dig("choices", 0, "message", "content").strip
  rescue => e
    Rails.logger.error "OpenAI Error: #{e.message}"
    nil
  end
end