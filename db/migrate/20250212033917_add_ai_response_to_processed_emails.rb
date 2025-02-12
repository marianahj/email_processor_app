class AddAiResponseToProcessedEmails < ActiveRecord::Migration[7.1]
  def change
    add_column :processed_emails, :ai_response, :text
  end
end
