class RemoveFieldsFromProcessedEmails < ActiveRecord::Migration[7.1]
  def change
    remove_column :processed_emails, :sender_email, :string
    remove_column :processed_emails, :subject, :string
    remove_column :processed_emails, :body, :string
    remove_column :processed_emails, :extracted_data, :string
  end
end
