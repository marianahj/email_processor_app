class ProcessedEmail < ApplicationRecord
  belongs_to :email, required: true, inverse_of: :processed_email
  belongs_to :order, optional: true  # Allow ProcessedEmail to exist without an Order

  validates_uniqueness_of :email_id
  def vendor
    JSON.parse(ai_response).dig("Vendor") || "undefined"
  end

  def order_id
    JSON.parse(ai_response).dig("OrderID") || "undefined"
  end

  def summary
    JSON.parse(ai_response).dig("EmailSummary") || "undefined"
  end

  def attention
    JSON.parse(ai_response).dig("NeedAttention") || "undefined"
  end

  def action
    action = JSON.parse(ai_response).dig("Action", "action")
    return "#{action} order" if action
    "undefined"
  end
end