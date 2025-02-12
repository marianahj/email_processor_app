class CreateProcessedEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :processed_emails do |t|
      t.string :sender_email
      t.string :subject
      t.text :body
      t.text :extracted_data

      t.timestamps
    end
  end
end
