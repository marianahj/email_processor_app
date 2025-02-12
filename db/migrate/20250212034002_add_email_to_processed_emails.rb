class AddEmailToProcessedEmails < ActiveRecord::Migration[7.1]
  def change
    add_reference :processed_emails, :email, null: false, foreign_key: true
  end
end
