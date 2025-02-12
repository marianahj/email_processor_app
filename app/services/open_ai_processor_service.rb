require 'openai'

class OpenAiProcessorService
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
          { role: "system", content: "Your role is to extract structured data from emails based on the following prompt: Analyze the email content and extract key information related to vendor, inventory, and order details. Return structured JSON with the following keys: Vendor (vendor name or ‘undefined’), OrderID (order ID or ‘undefined’), Inventory (materials and availability details or ‘undefined’), EmailSummary (concise 1-2 sentence summary of the email), NeedAttention (short description of any required human action or ‘undefined’), and Action (if the email contains an order action: { 'action': 'create' | 'delete', 'order_id': <order_id> } for creation/deletion, { 'action': 'update', 'order_id': <order_id>, 'field': '<field_name>', 'value': '<new_value>' } for updates, otherwise ‘undefined’). Ensure missing data is labeled explicitly as ‘undefined’ and return only structured JSON output without extra text."},
          { role: "user", content: email.body }
        ],
        temperature: 0.2
      }
    )

    message_content = response.dig("choices", 0, "message", "content").strip
    ProcessedEmail.create!(ai_response: message_content, email: email)
  rescue => e
    Rails.logger.error "OpenAI Error: #{e.message}"
    nil
  end
end